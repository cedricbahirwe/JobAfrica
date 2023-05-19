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
//            AppLaunchView(showLaunchView)
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
