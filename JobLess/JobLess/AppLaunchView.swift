//
//  AppLaunchView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 19/05/2023.
//

import SwiftUI

struct AppLaunchView: View {
    private var showLaunchView: Bool
    private var opacity: CGFloat
    
    init(_ isOn: Bool, _ opacity: CGFloat = 1.0) {
        self.showLaunchView = isOn
        self.opacity = opacity
    }
    
    var body: some View {
        ZStack {
            AppGradient.mainGradient
                .ignoresSafeArea()
                .opacity(opacity)
            
            VStack {
                Text("JobAfrica")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                ProgressView()
            }
        }
        .opacity(showLaunchView ? 1 : 0)
        .animation(.easeIn(duration: 1), value: showLaunchView)
    }
}


struct AppLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        AppLaunchView(false)
    }
}
