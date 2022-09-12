//
//  JobStoreManager.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 12/09/2022.
//

import Foundation
import FirebaseFirestore

final class JobStoreManager: ObservableObject {
    @Published private(set) var isLoading = false

    @Published private(set) var generalJobs: [Job] = []
    @Published private(set) var promoJobs: [Job] = []
    @Published private(set) var jobTags: [JobTag] = []
    
    private let db = Firestore.firestore()
    
    public init() {
        // Save User or update existing User
        try? saveUser(.getMetadata())
        
        // Load General Jobs
        loadJobs {
            self.generalJobs = $0.map({ $0.toDomainModel() }).sorted(by: { $0.postDate > $1.postDate})
        }
        
        // Load Promo Jobs
        loadJobs(isPromos: true) {
            self.promoJobs = $0.map({ $0.toDomainModel() }).sorted(by: { $0.postDate > $1.postDate})
        }

        // Load Job Tags
        loadTags {
            self.jobTags = $0.map({ $0.toDomainModel() }).sorted(by: { $0.rawValue < $1.rawValue})
        }
    }
    
    public func loadCompanies(completion: @escaping([JobCompany]) -> Void) {
        getContents(collection: .companies, completion: completion)
    }
    
    public func loadTags(completion: @escaping([JobTagModel]) -> Void) {
        getContents(collection: .jobTags, completion: completion)
    }
    
    public func loadCategories(completion: @escaping([JobTagModel]) -> Void) {
        getContents(collection: .jobCategories, completion: completion)
    }
    
    public func loadTypes(completion: @escaping([JobTypeModel]) -> Void) {
        getContents(collection: .jobTypes, completion: completion)
    }
    
    public func loadJobs(isPromos: Bool = false, completion:  @escaping([JobModel]) -> Void) {
        let collection: FirebaseCollection = isPromos ? .promo : .general
        getContents(collection: collection, completion: completion)
    }
    
    private func getContents<T: Decodable>(collection: FirebaseCollection,
                                           completion:  @escaping([T]) -> Void) {
        isLoading = true
        db.collection(collection)
            .addSnapshotListener { querySnapshot, error in
                self.isLoading = false
                if let error = error {
                    print("Firestore error:", error.localizedDescription)
                    completion([])
                    return
                }
                
                if let querySnapshot = querySnapshot {
                    let result = querySnapshot.documents.compactMap { document -> T? in
                        do {
                            let content = try document.data(as: T.self)
                            return content
                        } catch {
                            print("Firestore Decoding error:", error, querySnapshot.documents.forEach { print($0.data()) } )
                            return nil
                        }
                    }
                    completion(result)
                }
            }
    }
    
    func saveJob( _ newJob: JobModel, isPromo: Bool = false) {
        let collection: FirebaseCollection = isPromo ? .promo : .general
        do {
            let _ = try db.collection(collection).addDocument(from: newJob)
        } catch {
            print("Upload error:", error.localizedDescription)
        }
    }
    
    func updateJob(id: String, _ newJob: JobModel, isPromo: Bool = false) throws {
        let collection: FirebaseCollection = isPromo ? .promo : .general
        try db
            .collection(collection)
            .document(id)
            .setData(from: newJob) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
    }
    
    func viewJob(_ job: Job, isPromo: Bool = false) async throws {
        let collection: FirebaseCollection = isPromo ? .promo : .general
        let views = job.views + 1
        try await db
            .collection(collection)
            .document(job.id)
            .updateData(["views": views])
    }
    
    func saveUser(_ user: UserModel) throws {
        try db
            .collection(.users)
            .document(user.id ?? user.identifier)
            .setData(from: user) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
    }
}
