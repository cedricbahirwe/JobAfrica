//
//  JobType.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 09/09/2022.
//

import Foundation

public enum JobType: String, Codable, CaseIterable {
    case fullTime = "full-time"
    case partTime = "part-time"
    case contract
    case other
}
