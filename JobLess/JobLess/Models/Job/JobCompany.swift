//
//  JobCompany.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 09/09/2022.
//

import Foundation

public struct JobCompany: Codable {
    public var name: String
    public var description: String?
    public var logoURL: String?
    public var location: String
}
