//
//  JobCompany.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 09/09/2022.
//

import Foundation

struct JobCompany: Codable {
    var name: String
    var description: String?
    var logoURL: String?
    var location: String
}
