//
//  JobSearchView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct JobSearchView: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
                Button {
                    isPresented.toggle()
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
                .font(.headline.weight(.regular))

                Image(systemName: "arrow.right.circle")
                    .imageScale(.large)
                    .foregroundColor(.main)
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
        JobSearchView(isPresented: .constant(true))
    }
}
