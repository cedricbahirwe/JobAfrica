//
//  JobDescription.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 09/09/2022.
//

import Foundation

struct JobDescription: Codable {
    var paragraphs: [Paragraph]

    struct Paragraph: Hashable, Codable {
        let head: String?
        let body: String?
    }
}
