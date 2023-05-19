//
//  JobLessApp.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

@main
struct JobLessApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @AppStorage(UserDefaultsKeys.appColorScheme)
    private var appTheme: AppTheme = .dark

    @AppStorage(UserDefaultsKeys.showWelcomeView)
    private var showWelcomeView: Bool = true
    
//    @AppStorage(UserDefaultsKeys.appAccentColor)
//    var appAccentColor: Color = .mainRed
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .accentColor(.red)
//                .tint(appAccentColor)
                .sheet(isPresented: $showWelcomeView) {
                    WhatsNewView(isPresented: $showWelcomeView)
                        .accentColor(.red)
                }
                .preferredColorScheme(appTheme.colorScheme)
            
        }
    }
}
