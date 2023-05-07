//
//  JobSkill.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 09/09/2022.
//

import Foundation

struct JobSkill: Hashable, Codable {
    let name: String

    init(_ name: String) {
        self.name = name
    }
}
