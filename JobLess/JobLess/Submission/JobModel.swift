//
//  JobModel.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 12/09/2022.
//

import Foundation
import FirebaseFirestoreSwift

protocol BaseModel {
    associatedtype Model

    func toDomainModel() -> Model
}

public struct JobModel: Identifiable, Codable, BaseModel { 
    @DocumentID public var id: String?
    public var title: String
    public var postDate: Date
    public var jobLink: URL
    public var description: JobDescription
    public var company: JobCompany

    public var type: JobType
    public var category: JobCategory
    public var location: String
    public var contact: JobContact?

    public var tags: [JobTag]
    public var skills: [JobSkill]

    // OTHER
    public var views: Int = 0

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
