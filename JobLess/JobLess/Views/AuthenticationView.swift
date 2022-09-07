//
//  AuthenticationView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        VStack {

            HStack {
                Text("Powered by")
                Image("abc.logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 25)
            }
            .font(.system(size: 20, weight: .semibold, design: .rounded))
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
