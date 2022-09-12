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
    @State private var showAboutUs: Bool = false

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
                        HStack {
                            MenuItemView("Jobs", "Home", action: {
                                withAnimation {
                                    isPresented.toggle()
                                }
                            })

                            MenuItemView("About", "JobAfrica", action: {
                                showAboutUs.toggle()
                            })
                        }

                        HStack {
                            Link(destination: URL(string: "mailto:abc.incs.001@gmail.com")!) {
                                MenuItemView("Contact", "abc.incs.001@gmail.com", true, action: { })
                                    .disabled(true)
                            }
                        }
                    }
                }

                ThemeToggle { _ in
                    withAnimation {
                        isPresented.toggle()
                    }
                }
            }
            .padding()
            .foregroundColor(.white)
            .frame(maxWidth: screenSize.width*0.9, alignment: .trailing)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
        .background(Color.black)
        .offset(x: isPresented ? -screenSize.width*0.1 : -screenSize.width)
        .sheet(isPresented: $showAboutUs, content: AboutUsView.init)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(isPresented: .constant(true))
    }
}

extension MainMenuView {
    struct MenuItemView: View {
        init(_ title: String,
             _ subtitle: String,
             _ isSelected: Bool = false,
             action: @escaping () -> Void) {
            self.title = title
            self.subtitle = subtitle
            self.isSelected = isSelected
            self.action = action
        }

        let title: String
        let subtitle: String
        var isSelected: Bool
        var action: () -> Void

        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text(title)
                    .font(.callout)

                Text(subtitle)
                    .font(.title2.weight(.regular))
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 80)
            .background(isSelected ? Color.main : Color.gray.opacity(0.2))
            .cornerRadius(16)
            .onTapGesture(perform: action)
        }
    }
}
