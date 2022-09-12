//
//  ContentView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var showLaunchView = true

    var body: some View {
        ZStack {
            HomeView()

            LaunchView($showLaunchView)
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
    @Binding var showLaunchView: Bool

    init(_ isOn: Binding<Bool>) {
        _showLaunchView = isOn
    }

    var body: some View {
        ZStack {
            Color.main.ignoresSafeArea()

            VStack {
                Text("JobAfrica")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.foreground)


                ProgressView()
            }
        }
        .opacity(showLaunchView ? 1 : 0)
        .animation(.easeIn(duration: 1), value: showLaunchView)
    }
}
