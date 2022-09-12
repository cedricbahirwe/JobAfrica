//
//  JobCompany.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 09/09/2022.
//

import Foundation

public struct JobCompany: Hashable, Codable {
    public var name: String
    public var description: String?
    public var logoURL: URL?
    public var location: String
    public var website: URL?
}
