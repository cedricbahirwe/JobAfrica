//
//  JobCompany.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 09/09/2022.
//

import Foundation

struct JobCompany: Hashable, Equatable, Codable {
    var name: String
    var description: String?
    var logoURL: URL?
    var location: String
    var website: URL?
}
