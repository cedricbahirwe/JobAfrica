//
//  GoogleSheetsAPI.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 16/05/2023.
//

import Foundation
import GoogleSignIn
import GoogleAPIClientForREST_Sheets
import GoogleAPIClientForREST_Drive

@MainActor
final class GoogleSheetsAPI: ObservableObject {
    private let sheetLink = "https://docs.google.com/spreadsheets/d/1P3n23dvKgKuhwEpxMnGUMSGY3n2lrHBgu-UpWKQ6V4g/edit?usp=sharing"
        
    let sheetService = GTLRSheetsService()
    let driveService = GTLRDriveService()
    
    @Published var signInState = false
    
    @Published var servicesOn = false
    
    @Published var appendOn = false
    
    @Published var sendOn = false
    
    @Published var readOn = false
    

    
    func googleSignIn() {
        Task {
            self.signInState = await googleSigin()
            print("Signed in: \(signInState)")
        }
    }
    
    
    func initializeActivities() {
        sheetService.apiKey = K.apiKey
        sheetService.authorizer = GIDSignIn.sharedInstance.currentUser?.fetcherAuthorizer
        
        driveService.apiKey = K.apiKey
        driveService.authorizer = GIDSignIn.sharedInstance.currentUser?.fetcherAuthorizer
        
        servicesOn = true
    }
    
    func createJob(_ job: Job) {
        Task {
            do {
                let stringJob = try await createJob(job)
                self.appendOn = true
                print("Saved✅:", JobHelper.getJob(from: stringJob))
            } catch {
                print("Unable to save job", error.localizedDescription)
            }
        }
    }

    func getJobs() {
        Task {
            let stringJobs = await getJobs()
            self.appendOn = true
            print("New GIG:", stringJobs.count)
            print("=======")
            print("Final gigs", stringJobs.compactMap(JobHelper.getJob).count)
        }
    }
    
    func updateJob(_ job: Job) {
        Task {
            do {
                let stringJob = try await updateJob(job)
                self.sendOn = true
                print("Updated✅:", JobHelper.getJob(from: stringJob))
            } catch {
                print("Unable to save job", error.localizedDescription)
            }
        }
    }
}

// MARK: Spreadsheets Methods
private extension GoogleSheetsAPI {
    enum JobError: Error {
        case unableToSave(message: String? = nil)
        case unableToUpdate(message: String? = nil)
        case noResponse
        case emptyResponse
    }
    
    func createJob(_ job: Job) async throws -> [String] {
        try await withUnsafeThrowingContinuation { (continuation: UnsafeContinuation<[String], Error>) in
            
            let rangeToAppend = GTLRSheets_ValueRange()
            rangeToAppend.values = [JobHelper.getValues(from: job)]
            
            let range = "A2:R"
            
            let query = GTLRSheetsQuery_SpreadsheetsValuesAppend.query(withObject: rangeToAppend, spreadsheetId: K.sheetID, range: range)
            query.valueInputOption = "USER_ENTERED"
            query.includeValuesInResponse = true
            
            sheetService.executeQuery(query) { (ticket, result, error) in
                if let error {
                    continuation.resume(throwing: JobError.unableToSave(message: error.localizedDescription))
                } else {
                    guard let result = result as? GTLRSheets_AppendValuesResponse else {
                        continuation.resume(throwing: JobError.noResponse)
                        return
                    }
                    
                    guard let rows = result.updates?.updatedData?.values, !rows.isEmpty else {
                        continuation.resume(throwing: JobError.emptyResponse)
                        return
                    }
                    
                    let stringRows = rows as! [[String]]
                    continuation.resume(returning: stringRows[0])
                }
            }
        }
    }
    
    func updateJob(_ job: Job) async throws -> [String] {
        try await withUnsafeThrowingContinuation { (continuation: UnsafeContinuation<[String], Error>) in
            
            let currentRange = "A5:R"
            let rangeToAppend = GTLRSheets_ValueRange();
            rangeToAppend.values = [JobHelper.getValues(from: job)]
            
            let query = GTLRSheetsQuery_SpreadsheetsValuesUpdate.query(withObject: rangeToAppend, spreadsheetId: K.sheetID, range: currentRange)
            query.valueInputOption = "USER_ENTERED"
            query.includeValuesInResponse = true
            
            sheetService.executeQuery(query) { (ticket, result, error) in
                if let error = error {
                    continuation.resume(throwing: JobError.unableToUpdate(message: error.localizedDescription))
                    return
                } else {
                    
                    guard let result = result as? GTLRSheets_ValueRange else {
                        print("Failure")
                        continuation.resume(throwing: JobError.noResponse)
                        return
                    }
                    
                    let rows = result.values! as! [[String]]
                    
                    continuation.resume(returning: rows[0])
                }
            }
        }
    }
    
    func getJobs() async -> [[String]] {
        do {
            return try await withUnsafeThrowingContinuation { (continuation) in
                let range = "A2:R"
                let query = GTLRSheetsQuery_SpreadsheetsValuesGet
                    .query(withSpreadsheetId: K.sheetID, range:range)
                
                sheetService.executeQuery(query) { (ticket, result, error) in
                    if let error = error {
                        continuation.resume(throwing: error)
                        return
                    }
                    
                    guard let result = result as? GTLRSheets_ValueRange else {
                        continuation.resume(returning: [])
                        return
                    }
                    
                    let rows = result.values!
                    guard !rows.isEmpty else {
                        continuation.resume(returning: [])
                        return
                    }
                    
                    let stringRows = rows as! [[String]]
                    
                    continuation.resume(returning: stringRows)
                    
                    print("Number of rows in sheet: \(rows.count)")
                    
                }
            }
        } catch {
            print("Unable to get jobs: ", error.localizedDescription)
            return []
        }
      
    }
}

// MARK: Google Sign In
extension GoogleSheetsAPI {
    func googleSigin() async -> Bool {
        do {
            let foundUser = try await GIDSignIn.sharedInstance.restorePreviousSignIn()
            return await requestScopes(googleUser: foundUser)
            
        } catch {
            print("No previous user!\nThis is the error: \(String(describing: error.localizedDescription))")
            do {
                let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: self.getRootViewController())
                return await requestScopes(googleUser: signInResult.user)
            } catch {
                print("Error with signing in: \(String(describing: error.localizedDescription)) ")
                self.sheetService.authorizer = nil
                return false
            }
        }
    }
    
    func requestScopes(googleUser: GIDGoogleUser) async -> Bool {
        let grantedScopes = googleUser.grantedScopes
        
        if let grantedScopes, grantedScopes.contains(K.grantedScopes) {
            print("Already contains the scopes!")
            return true
        } else {
            do {
                let signInResult = try await googleUser.addScopes(K.additionalScopes, presenting: getRootViewController())
                
                self.sheetService.authorizer = signInResult.user.fetcherAuthorizer
                print("No errors found at all")
                return true
            } catch {
                print("Error with adding scopes: \(String(describing: error.localizedDescription))")
                return false
            }
        }
    }
        
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root =
                screen.windows.first?.rootViewController else{
            return .init()
        }
        return root
    }
}
