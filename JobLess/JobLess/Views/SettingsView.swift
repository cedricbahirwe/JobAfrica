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
    private let columns = Array(repeating: GridItem(), count: 4)
    
    @Binding var appAccentColor: Color
    
    @State private var internalAccentColor: Color
    
    init(isPresented: Binding<Bool>, screenSize: CGSize, appAccentColor: Binding<Color>) {
        self._isPresented = isPresented
        self.screenSize = screenSize
        self._appAccentColor = appAccentColor
        self._internalAccentColor = State(initialValue: appAccentColor.wrappedValue)
    }
    
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
                            .foregroundColor(appAccentColor)
                    }
                }
                .padding(.horizontal)
                
                Form {
                    
                    HStack {
                        optionView("Jobs", "Home", action: {
                            withAnimation {
                                isPresented.toggle()
                            }
                        })
                        
                        optionView("About", "JobAfrica", action: {
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
                    
                    Section {
                        LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                            ForEach(AppGradient.randomColors, id: \.self) { uiColor in
                                let color = Color(uiColor)
                                color
                                    .frame(maxWidth: .infinity)
                                    .scaledToFit()
                                    .cornerRadius(15, antialiased: false)
                                    .padding(internalAccentColor.isEqualTo(color) ? 10 : 0)
                                    .overlay {
                                        if internalAccentColor.isEqualTo(color) {
                                            RoundedRectangle(cornerRadius: 15)
                                                .strokeBorder(color, lineWidth: 1)
                                        }
                                    }
                                    .onAppear() {
                                        isEqual(internalAccentColor, color)
                                    }
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            internalAccentColor = color
                                        }
                                        appAccentColor = color
                                    }
                            }
                            
                        }
                    } header: {
                        Text("App Main Color")
                    } footer: {
                        Text("The selected color will be used to highlight interactive elements in the user interface.")
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
        .sheet(isPresented: $presentAboutView) { AboutUsView().accentColor(appAccentColor) }
        .onChange(of: isPresented) { newValue in
            print("Change happened", newValue)
            isEqual(appAccentColor, internalAccentColor)
        }
        
    }
    
    private func isEqual(_ c1: Color, _ c2: Color)  {
        let co1 = UIColor(c1).cgColor
        let co2 = UIColor(c2).cgColor
        
        
        let components1 = co1.components!
        let components2 = co2.components!
        
        print("========================")
        print("Les ", co1 == co2)

        print("Ennohter:", components1, components2)
        print("finals", appAccentColor.isEqualTo(c2))
     
//        return c1.rawValue == c2.rawValue
    }
    private func formLink(_ icon : String, _ title: String, _ link: URL) -> some View {
        Link(destination: link) {
            Label {
                Text(title)
                    .foregroundColor(.primary)
            } icon: {
                Image(systemName: icon)
                    .foregroundColor(appAccentColor)
            }
        }
        .font(.body.weight(.medium))
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(isPresented: .constant(true),
//                     screenSize: UIScreen.main.bounds.size)
//    }
//}

private extension SettingsView {
    func optionView(_ title: String,
                    _ subtitle: String,
                    action: @escaping () -> Void) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.callout)
                .bold()
            Text(subtitle)
                .font(.title2.weight(.regular))
                .foregroundColor(appAccentColor)
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
