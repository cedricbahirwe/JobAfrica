//
//  WhatsNewView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 12/09/2022.
//

import SwiftUI

struct WhatsNewView: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Image("app.logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .cornerRadius(20)

                VStack {
                    Text("JobAfrica")
                        .font(.system(.title, design: .rounded).weight(.heavy))
                        .foregroundColor(.main)

                    Text("Find work you love in Africa.")
                        .font(.headline)
                        .opacity(0.95)
                }

            }

            VStack(spacing: 18) {

                Text("What's in for you?")
                    .font(.system(.title, design: .rounded).weight(.heavy))
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)

                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 20) {

                        featureView(icon: "clock.circle",
                                    title: "Up to Date",
                                    subtitle: "Get recently posted job suggestions.")

                        featureView(icon: "lock.shield.fill",
                                    title: "Data Protection",
                                    subtitle: "Your Privacy is our topmost concern, so We do not collect any data from you.")

                        featureView(icon: "suit.club.fill",
                                    title: "My Space",
                                    subtitle: "Enjoy a nice and smooth experience with no interrupting ads.")

                    }
                    .padding(.horizontal, 2)
                }

                Button {
                    isPresented = false
                } label: {
                    Text("Continue")
                        .font(.body.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.main)
                        .cornerRadius(15)
                        .shadow(color: Color(.darkGray), radius: 3, x: 3, y: 3)
                        .foregroundColor(.white)
                }
                .padding(.vertical)
            }
        }
        .padding()
        .background(Color(.systemBackground))
    }

    private func featureView(icon: String, title: LocalizedStringKey, subtitle: LocalizedStringKey) -> some View {
        HStack(spacing: 10) {

            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.main)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(.title3, design: .rounded).weight(.semibold))
                    .contrast(0.85)

                Text(subtitle)
                    .opacity(0.8)
                    .font(.system(.callout, design: .rounded))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct WhatsNewView_Previews: PreviewProvider {
    static var previews: some View {
        WhatsNewView(isPresented: .constant(false))
//            .preferredColorScheme(.dark)
    }
}
