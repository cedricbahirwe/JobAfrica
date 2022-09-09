//
//  JobSkill.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 09/09/2022.
//

import Foundation

public struct JobSkill: Codable {
    let name: String

    public init(_ name: String) {
        self.name = name
    }
}
