//
//  JobSearchView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct JobSearchView: View {
    @Binding var searchEntry: String
    @Binding var isPresented: Bool

    @FocusState var focus: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
                Button {
                    isPresented.toggle()
                    searchEntry = ""
                } label: {
                    Image(systemName: "arrow.left")
                        .imageScale(.large)
                        .font(.body.weight(.bold))
                        .frame(width: 40, height: 40)
                        .foregroundColor(.primary)
                }

                Text("Search")
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
            }

            HStack {
                TextField("Search for a job title, e.g: developer",
                          text: .constant(""))
                .focused($focus)
                .font(.headline.weight(.regular))
                .onChange(of: isPresented) { newValue in
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        focus = newValue
                    }
                }

                Image(systemName: "arrow.right.circle")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }

            ScrollView {

                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Group {
                            Text("Web Developer")
                            Text("Mobile Developer")
                            Text("Engineer")
                            Text("Design")
                            Text("Accountant")
                        }
                        .font(.title3.weight(.light))
                    }
                } header: {
                    Text("Popular Searches")
                        .font(.title3)
                        .padding(.vertical, 10)
                }

            }
        }
        .padding()
        .background(Color(.secondarySystemBackground), ignoresSafeAreaEdges: .all)
    }
}

struct JobSearchView_Previews: PreviewProvider {
    static var previews: some View {
        JobSearchView(searchEntry: .constant(""),
                      isPresented: .constant(true))
    }
}
