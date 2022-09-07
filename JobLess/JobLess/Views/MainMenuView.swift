//
//  MainMenuView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct MainMenuView: View {
    @Binding var isPresented: Bool
    var screenSize = UIScreen.main.bounds.size
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Menu")
                        .font(.system(.title3, design: .rounded).weight(.black))
                        .textCase(.uppercase)
                    Spacer()

                    Button {
                        withAnimation {
                            isPresented.toggle()
                        }
                    } label: {
                        Image(systemName: "x.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    }
                }

                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(0 ..< 5) { item in
                            HStack {
                                VStack(alignment: .leading, spacing: 20) {
                                    Text("Jobs")
                                        .font(.callout)

                                    Text("Home")
                                        .font(.title2.weight(.regular))
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 80)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(16)

                                VStack(alignment: .leading, spacing: 20) {
                                    Text("Jobs")
                                        .font(.callout)

                                    Text("Home")
                                        .font(.title2.weight(.regular))
                                }
                                .padding(20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 80)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(16)
                            }
                        }
                    }
                }
                ThemeToggle()
            }
            .padding()
            .foregroundColor(.white)
            .frame(maxWidth: screenSize.width*0.9, alignment: .trailing)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
        .background(Color.black)
        .offset(x: isPresented ? -screenSize.width*0.1 : -screenSize.width)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(isPresented: .constant(true))
    }
}
