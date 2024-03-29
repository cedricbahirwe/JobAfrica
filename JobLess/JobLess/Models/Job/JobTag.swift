//
//  JobTag.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import Foundation

enum JobTag: String, Codable, CaseIterable {
    case all
    case mobile
    case iOS
    case android
    case web
    case backend
    case frontend
    case other

    var formatted: String {
        switch self {
        case .iOS:
            return "iOS"
        default:
            return rawValue.capitalized
        }
    }
}
