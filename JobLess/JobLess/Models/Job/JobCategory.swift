//
//  JobCategory.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 09/09/2022.
//

import Foundation

public enum JobCategory: String, Codable, CaseIterable {
    case hybrid
    case remote
    case onsite = "on-site"
    case other
}
