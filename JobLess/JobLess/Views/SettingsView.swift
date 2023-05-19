//
//  SettingsView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isPresented: Bool
    let screenSize: CGSize
    @State private var presentAboutView: Bool = false
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Settings")
                        .font(.system(.title, design: .rounded).weight(.black))
                    Spacer()
                    
                    Button {
                        withAnimation {
                            isPresented.toggle()
                        }
                    } label: {
                        Image(systemName: "chevron.backward.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .foregroundColor(.main)
                    }
                }
                .padding(.horizontal)
                
                Form {
                    
                    HStack {
                        MenuItemView("Jobs", "Home", action: {
                            withAnimation {
                                isPresented.toggle()
                            }
                        })
                        
                        MenuItemView("About", "JobAfrica", action: {
                            presentAboutView.toggle()
                        })
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    Section {
                        formLink("list.bullet.rectangle.portrait.fill",
                                 "Tell us what you think",
                                 URL(string: "https://forms.gle/rHYNsppV2cDVtYsx8")!)
                        
                        
                        formLink("envelope.fill",
                                 "Email us",
                                 URL(string: "mailto:abc.incs.001@gmail.com")!)
                        
                        formLink("star.fill",
                                 "Rate us on AppStore",
                                 URL(string: "https://apps.apple.com/us/app/kongoinfo/id6448764651?action=write-review")!)
                    }
                }
                
                ThemeToggle { _ in
                    withAnimation {
                        isPresented.toggle()
                    }
                }
                .padding(.horizontal)
                
            }
            .frame(maxWidth: screenSize.width*0.9, alignment: .trailing)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
        .background(Color(.systemGroupedBackground))
        .offset(x: isPresented ? -screenSize.width*0.1 : -screenSize.width)
        .colorScheme(.dark)
        .sheet(isPresented: $presentAboutView, content: AboutUsView.init)
    }
    
    private func formLink(_ icon : String, _ title: String, _ link: URL) -> some View {
        Link(destination: link) {
            Label {
                Text(title)
                    .foregroundColor(.primary)
            } icon: {
                Image(systemName: icon)
                    .foregroundColor(.main)
            }
        }
        .font(.body.weight(.medium))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true),
                     screenSize: UIScreen.main.bounds.size)
        .preferredColorScheme(.light)
        SettingsView(isPresented: .constant(true),
                     screenSize: UIScreen.main.bounds.size)
        .preferredColorScheme(.dark)
    }
}

extension SettingsView {
    struct MenuItemView: View {
        init(_ title: String,
             _ subtitle: String,
             action: @escaping () -> Void) {
            self.title = title
            self.subtitle = subtitle
            self.action = action
        }
        
        let title: String
        let subtitle: String
        var action: () -> Void
        
        var body: some View {
            VStack(alignment: .leading, spacing: 15) {
                Text(title)
                    .font(.callout)
                    .bold()
                Text(subtitle)
                    .font(.title2.weight(.regular))
                    .foregroundColor(.main)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 80)
            .background(.ultraThinMaterial)
            .background(.black.opacity(0.1))
            .cornerRadius(16)
            .onTapGesture(perform: action)
        }
    }
}
