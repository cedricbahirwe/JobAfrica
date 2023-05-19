//
//  Colors+.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

extension Color {
    static var main: Color {
        ColorWrapper.getColor() ?? Color("primary.red")
    }

    static let foreground = Color(.systemBackground)
    
    static let darkerBackground = Color(red: 15/255, green: 21/255, blue: 27/255)
}

enum ColorWrapper {
    
    static func setDefaults(_ color: Color = AppGradient.randomColor) {
        let defaults = UserDefaults.standard

        guard defaults.data(forKey: UserDefaultsKeys.appAccentColor) == nil else { return }
        saveColor(color)
    }
    
    static func saveColor(_ color: Color) {
        guard let colorData = color.encode() else { return }
        UserDefaults.standard.setValue(colorData, forKey: UserDefaultsKeys.appAccentColor)
    }
    
    static func getColor() -> Color? {
        guard let colorData = UserDefaults.standard.data(forKey: UserDefaultsKeys.appAccentColor) else { return nil }
        guard let uiColor = Color.decode(data: colorData) else { return nil }
        return Color(uiColor)
    }
}

extension Color {
    func encode() -> Data? {
        do {
            return try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false)//.base64EncodedData()
        } catch {
            print("Error encoding color:", error)
            return nil
        }
    }
    
    static func decode(data: Data) -> UIColor? {
        do {
            return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
        } catch {
            print("Error decoding color:", error)
            return nil
        }
    }
}

//extension Color: RawRepresentable {
//    public init?(rawValue: String) {
//        guard let data = Data(base64Encoded: rawValue) else {
//            self = Color.main
//            return
//        }
//        do {
//            let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor ?? UIColor(Color.main)
//            
//            self = Color(color)
//        } catch {
//            self = .gray
//        }
//    }
//    
//    public var rawValue: String {
//        do {
//            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
//
//            return data.base64EncodedString()
//        } catch {
//            return ""
//        }
//    }
//}
