//
//  ContentView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showLaunchView = true
    
    var body: some View {
        ZStack {
            HomeView()
            
            LaunchView(showLaunchView)
        }
        .onAppear {
            showLaunchView = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LaunchView: View {
    private var showLaunchView: Bool
    private var opacity: CGFloat
    
    init(_ isOn: Bool, _ opacity: CGFloat = 1.0) {
        self.showLaunchView = isOn
        self.opacity = opacity
    }
    
    var body: some View {
        ZStack {
            Color.main.ignoresSafeArea()
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
