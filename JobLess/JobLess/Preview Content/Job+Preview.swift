//
//  Job+Preview.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 09/09/2022.
//

import Foundation

extension Job {
    static let customerService = Job(id: UUID().uuidString,
                                     title: "Customer Service Assistant",
                                     postDate: .init(timeIntervalSinceNow: 86_400),
                                     jobLink: URL(string: "https://www.google.com")!,
                                     description: "Requirements: Excellent customer service, written and verbal communication skills. Understanding of the sales process. Experience in Retail Sector, Perfumes, Cosmetics, Fashion and Electronics is a plus. Preferably Graduates. Applicable for Bahrainis only.",
                                     company: .init(name: "Visit Congo",
                                                    location: "Lubumbashi"),
                                     type: .fullTime,
                                     category: .onsite,
                                     location: "Katanga",
                                     contact: .init(email: "visicongo@gmail.com"),
                                     tags: [.all],
                                     skills: [.init("Communication")])
    
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
                                                 whatsapp: "+250 782 628 511"),
                                  tags: [.all, .iOS, .mobile],
                                  skills: [JobSkill("iOS "),
                                           JobSkill("UIKit")],
                                  views: 0)
}
