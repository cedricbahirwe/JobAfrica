//
//  User.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 12/09/2022.
//

import Foundation

public struct User: Codable, Identifiable {
    public var id: String { identifier }
    
    public let name: String
    public let model: String
    public let identifier: String
    public let osName: String
    public let osVersion: String
    public let lastSeenDate: Date
}
