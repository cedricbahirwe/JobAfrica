//
//  ThemeToggle.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct ThemeToggle: View {
    @AppStorage(UserDefaultsKeys.appColorScheme)
    private var appTheme: AppTheme = .dark
    var onThemeChange: (_ newTheme: AppTheme) -> Void

    var body: some View {
        Picker("App Theme", selection: $appTheme) {
            ForEach(AppTheme.allCases, id: \.self) { theme in
                Text(theme.rawValue.capitalized)
            }
        }
        .onChange(of: appTheme, perform: onThemeChange)
        .pickerStyle(SegmentedPickerStyle())
    }
}
struct ThemeToggle_Previews: PreviewProvider {
    static var previews: some View {
        ThemeToggle() { _ in }
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
