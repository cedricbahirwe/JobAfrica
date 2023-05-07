//
//  Job.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 09/09/2022.
//

import Foundation

struct Job: Identifiable, Codable {
    var id: String
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
}

extension Job {
    var miniDescription: String? {
        description.paragraphs.first?.body
    }
}
