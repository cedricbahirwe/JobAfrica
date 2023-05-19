//
//  Colors+.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

extension Color {
    static var mainRed = Color("primary.red")

    static let darkerBackground = Color(red: 15/255, green: 21/255, blue: 27/255)
}

extension Color: RawRepresentable {
    
    public init?(rawValue: String) {
        if let components = UserDefaults.standard.object(forKey: UserDefaultsKeys.appAccentColor) as? [CGFloat], components.count >= 4 {
            let color = Color(.sRGB,
                              red: components[0],
                              green: components[1],
                              blue: components[2],
                              opacity: components[3])
            self = color
        } else {
            self = .mainRed
        }
    }
    
    public var rawValue: String {
        if let components = UIColor(self).cgColor.components {
            UserDefaults.standard.set(components, forKey: UserDefaultsKeys.appAccentColor)
            return components.map { String(describing: $0) }.joined(separator: "-")
        } else {
            return ""
        }
    }
    
    func isEqualTo(_ c2: Color) -> Bool {
        self.rawValue == c2.rawValue
    }
}
    
//    public init?(rawValue: String) {
//
//        guard let data = Data(base64Encoded: rawValue) else{
//            self = .mainRed
//            return
//        }
//
//        do {
//            if let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor {
//                self =  Color(color)
//            } else {
//                self = .mainRed
//            }
//        } catch {
//            self = .mainRed
//        }
//    }
    
//    public var rawValue: String {
//        do {
//            if let components = UIColor(self).cgColor.components {
//                UserDefaults.standard.set(components, forKey: UserDefaultsKeys.appAccentColor)
//                return ""
//            } else {
//                return ""
//            }
//        } catch {
//            return ""
//        }
//    }
    
//    func isEqualTo(_ c2: Color) -> Bool {
//        self.rawValue == c2.rawValue
//    }
    

