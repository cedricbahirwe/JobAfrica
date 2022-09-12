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
    let persistenceController = PersistenceController.shared
    
    @AppStorage("app.colorscheme")
    private var appTheme: AppTheme = .dark

    var body: some Scene {
        WindowGroup {
            SubmitterView()
//            ContentView()
                .preferredColorScheme(appTheme.colorScheme)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
