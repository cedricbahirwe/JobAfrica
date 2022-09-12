//
//  UserDefaults+.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 12/09/2022.
//

import Foundation

typealias UserDefaultsKeys = UserDefaults.Keys
public extension UserDefaults {

    /// Storing the used UserDefaults keys for safety.
    enum Keys {
        static let appColorScheme = "app.colorscheme"
        // Onboarding
        static let showWelcomeView = "showWelcomeView"
    }
}
