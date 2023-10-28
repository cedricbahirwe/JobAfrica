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
        let data = Data(base64Encoded: rawValue)!
        let color = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! UIColor
        self =  Color(color)
    }
    
    public var rawValue: String {
        let data = try! NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
        return data.base64EncodedString()
    }
}

extension Color {
    func isEqualTo(_ c2: Color) -> Bool {
        UIColor(self).cgColor.components!.map({ String(format: "%.3f", $0) }) == UIColor(c2).cgColor.components!.map({ String(format: "%.3f", $) })
    }
}
