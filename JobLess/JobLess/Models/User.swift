//
//  User.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 12/09/2022.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String { identifier }
    
    let name: String
    let model: String
    let identifier: String
    let osName: String
    let osVersion: String
    let lastSeenDate: Date
}
