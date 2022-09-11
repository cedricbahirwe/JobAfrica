//
//  Job.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 09/09/2022.
//

import Foundation

public struct Job: Identifiable, Codable {
    public var id: String
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
}
