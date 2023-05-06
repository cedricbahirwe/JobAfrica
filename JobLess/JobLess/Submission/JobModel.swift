//
//  JobModel.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 12/09/2022.
//

import Foundation
import UIKit
import FirebaseFirestoreSwift

protocol BaseModel {
    associatedtype Model

    func toDomainModel() -> Model
}

struct JobModel: Identifiable, Codable, BaseModel { 
    @DocumentID var id: String?
    var title: String
    var postDate: Date
    var jobLink: URL
    var description: JobDescription
    var company: JobCompany

    var type: JobType
    var category: JobCategory
    var location: String
    var contact: JobContact?

    var tags: [JobTag]
    var skills: [JobSkill]

    // OTHER
    var views: Int = 0

    func toDomainModel() -> Job {
        Job(id: id!,
            title: title,
            postDate: postDate,
            jobLink: jobLink,
            description: description,
            company: company,
            type: type,
            category: category,
            location: location,
            contact: contact,
            tags: tags,
            skills: skills,
            views: views)
    }

    static let example = JobModel(title: "iOS engineer ",
                                  postDate: Date(),
                                  jobLink: URL(string: "https://www.hackingwithswift.com/forums/jobs/ios-engineer-at-anima/15024")!,
                                  description: JobDescription(paragraphs: [JobDescription.Paragraph(head: nil, body: Optional("Anima Virtuality is looking for an iOS developer.\n\nThis job is fully remote.\n\nAnima objects are limited-edition digital works created in collaboration with the world’s most innovative artists, including Demsky, Michael Kagan, and Lyle Owerko. In the Anima app, experience Anima objects that evolve and change based on your actions and environment. This job is for someone with a strong passion iOS development."))]),
                                  company: JobCompany(name: "ABC Incs",
                                                      description: Optional("Softwares, for People by People"),
                                                      logoURL: URL(string: "https://avatars.githubusercontent.com/u/88772676?s=200&v=4")!,
                                                      location: "Congo (Kinshasa)",
                                                      website: URL(string: "https://github.com/ABCIncs")!),
                                  type: JobType.fullTime,
                                  category: JobCategory.remote,
                                  location: "Anima US",
                                  contact: .init(email: "cedric@gmail.com",
                                                 whatsapp: "+250 782 628 511",
                                                 telegram: nil),
                                  tags: [.all, .iOS, .mobile],
                                  skills: [JobSkill("iOS "),
                                           JobSkill("UIKit")],
                                  views: 0)
}


struct JobTagModel: Codable, BaseModel {
    let value: String

    func toDomainModel() -> JobTag {
        JobTag(rawValue: value) ?? .other
    }
}

struct JobTypeModel: Codable, BaseModel {
    let value: String

    func toDomainModel() -> JobType {
        JobType(rawValue: value) ?? .other
    }
}

struct JobCategoryModel: Codable, BaseModel {
    let value: String

    func toDomainModel() -> JobCategory {
        JobCategory(rawValue: value) ?? .other
    }
}

struct UserModel: Codable, BaseModel {
    @DocumentID var id: String?
    let name: String
    let model: String
    let identifier: String
    let osName: String
    let osVersion: String
    let lastSeenDate: Date

    static func getMetadata() -> UserModel {
        let device = UIDevice.current
        let osVersion = device.systemVersion
        let osName = device.systemName.lowercased()
        let deviceModel = device.model
        let name = device.name
        let identifier = device.identifierForVendor?.uuidString  ?? UUID().uuidString

        return UserModel(id: identifier,
                         name: name,
                         model: deviceModel,
                         identifier: identifier,
                         osName: osName,
                         osVersion: osVersion,
                         lastSeenDate: Date())
    }

    func toDomainModel() -> User {
        User(name: name,
             model: model,
             identifier: identifier,
             osName: osName,
             osVersion: osVersion,
             lastSeenDate: lastSeenDate)
    }
}
