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
