//
//  Gradient.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 19/05/2023.
//

import SwiftUI

enum AppGradient {
    static var mainGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 13/255, green: 29/255, blue: 79/255),
                Color(red: 13/255, green: 22/255, blue: 36/255),
                Color(red: 28/255, green: 75/255, blue: 102/255),
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    static let randomColors: [Color] = [.mint,  .teal, .cyan, .blue, .green, .orange, .yellow, .indigo, .purple, .pink, .mainRed, .red]
    
    static var randomColor: Color {
        randomColors.randomElement()!
    }
}
