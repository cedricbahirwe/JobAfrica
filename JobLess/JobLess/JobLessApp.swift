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

    var body: some Scene {
        WindowGroup {
            //            SubmitterView()
            ContentView()
                .sheet(isPresented: $showWelcomeView) {
                    WhatsNewView(isPresented: $showWelcomeView)
                }
                .preferredColorScheme(appTheme.colorScheme)
        }
    }
}
