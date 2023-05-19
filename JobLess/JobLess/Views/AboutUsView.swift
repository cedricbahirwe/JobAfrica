//
//  AboutUsView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 12/09/2022.
//

import SwiftUI

struct AboutUsView: View {
    @Environment(\.dismiss)
    private var dismiss

    private let appVersion = UIApplication.appVersion ?? "1.0"
    private let buildVersion = UIApplication.buildVersion ?? "1"
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            VStack {
                Image("app.logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .cornerRadius(15)
                    .padding()

                Text("JobAfrica")
                    .font(.system(.title2, design: .rounded).weight(.bold))
                    .foregroundColor(.accentColor)
            }
            .padding(.top, 30)

            VStack(spacing: 10) {
                Text("Version \(appVersion)")
                    .fontWeight(.bold)

                Text("Build \(buildVersion)")
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
            }

            Text("Designed and developed by\n[Cédric Bahirwe](https://www.linkedin.com/in/cedricbahirwe)")
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .tint(.accentColor)

            Spacer()

            Button {
                dismiss()
            } label: {
                Text("Done")
                    .font(.system(.body).weight(.bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.accentColor)
                    .cornerRadius(15)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
