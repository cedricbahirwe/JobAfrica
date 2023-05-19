//
//  AppDelegate.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 11/09/2022.
//

import UIKit
import FirebaseCore
import GoogleSignIn

final class AppDelegate: NSObject, UIApplicationDelegate {
    private let signInConfig = GIDConfiguration.init(clientID: K.clientID)
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
                        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: K.clientID)

        
//        ColorWrapper.setDefaults()
        
        GIDSignIn.sharedInstance.configuration = config
        
        Task {
            try? await GIDSignIn.sharedInstance.restorePreviousSignIn()
        }
        
        FirebaseApp.configure()

        return true
    }
    
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        if GIDSignIn.sharedInstance.handle(url) {
            return true
        }
        
        return false
    }
}

enum K {
    static let clientID = "167509651075-24mq6dteaj3u1gmh8jteba7eqcv8fg7k.apps.googleusercontent.com"

    static let apiKey = "AIzaSyC0SxsNEDJjhI8p9KHUOQOUSF3sAVdv8rk"
    
    static let grantedScopes = "https://www.googleapis.com/auth/spreadsheets"
    static let additionalScopes = [
        "https://www.googleapis.com/auth/spreadsheets",
        "https://www.googleapis.com/auth/drive.file"]
    
    static let sheetID = "1P3n23dvKgKuhwEpxMnGUMSGY3n2lrHBgu-UpWKQ6V4g"
}
