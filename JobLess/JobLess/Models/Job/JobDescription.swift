//
//  JobDescription.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 09/09/2022.
//

import Foundation

public struct JobDescription: Codable {
    public var paragraphs: [Paragraph]

    public struct Paragraph: Hashable, Codable {
        public let head: String?
        public let body: String?
    }
}
