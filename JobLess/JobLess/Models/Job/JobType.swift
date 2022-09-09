//
//  JobType.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 09/09/2022.
//

import Foundation

enum JobType: String, Codable {
    case fullTime
    case partTime = "part-time"
    case contract
    case other
}
