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
                                     postDate: .now,
                                     jobLink: URL(string: "https://www.google.com")!,
                                     description: .init(paragraphs: [
                                        .init(head: nil,
                                              body: "Requirements: Excellent customer service, written and verbal communication skills. Understanding of the sales process. Experience in Retail Sector, Perfumes, Cosmetics, Fashion and Electronics is a plus. Preferably Graduates. Applicable for Bahrainis only.")
                                     ]),
                                     company: .init(name: "Visit Congo",
                                                    location: "Lubumbashi"),
                                     type: .fullTime,
                                     category: .onsite,
                                     location: "Katanga",
                                     contact: .init(email: "visicongo@gmail.com"),
                                     tags: [.all],
                                     skills: [.init("Communication")])
}

