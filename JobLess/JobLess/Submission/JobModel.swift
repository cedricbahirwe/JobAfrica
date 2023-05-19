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
            description: description.fullDescription,
            company: company,
            type: type,
            category: category,
            location: location,
            contact: contact ?? .init(),
            tags: tags,
            skills: skills,
            views: views)
    }
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
