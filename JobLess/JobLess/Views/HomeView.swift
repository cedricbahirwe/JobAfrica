//
//  HomeView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI
enum JobTags: String, Codable, CaseIterable {
    case all
    case mobile
    case iOS
    case android
    case web
    case backend
    case frontend

    var formatted: String {
        switch self {
        case .iOS:
            return "iOS"
        default:
            return rawValue.capitalized
        }
    }
}

struct ThemeToggle: View {
    init(_ sheme: Binding<ColorScheme?>) {
        _colorScheme = sheme

    }
    @Environment(\.colorScheme)
    private var activeScheme
    @Binding var colorScheme: ColorScheme?
    @State private var isDarkModeOn: Bool = false

    var body: some View {
        HStack {
            Label("Light Theme", systemImage: isDarkModeOn ?  "sun.max" : "sun.max.fill")
                .labelStyle(.iconOnly)
            Toggle("Theme Toggle", isOn: $isDarkModeOn)
                .labelsHidden()
                .scaleEffect(0.8)
                .tint(.main)
            Label("Dark Theme", systemImage: isDarkModeOn ? "moon.circle.fill" :  "moon.stars")
                .labelStyle(.iconOnly)
                .animation(.easeInOut, value: isDarkModeOn)
        }
        .onChange(of: isDarkModeOn) { colorScheme = $0 ? .dark : .light }
        .onAppear() {
            colorScheme = activeScheme
            isDarkModeOn = activeScheme == .dark
        }
    }
}
struct HomeView: View {
    @State private var colorScheme: ColorScheme? = nil
    @State var selectedJobTag: JobTags = JobTags.all
    @State var showDetailView = false

    var body: some View {
        ZStack {
            VStack {
                NavigationBarView(onMenu: {},
                              onSearch: {},
                              onFilter: {})


                VStack(alignment: .leading, spacing: 20) {
                    Text("Find the best job for you\n\(Text("in Africa 🌍").bold())")
                        .font(.system(.title, design: .rounded))
                        .layoutPriority(2)

                    jobsAdvertsView

                    JobTagsView(JobTags.allCases, selection: $selectedJobTag)

                    recentPostedJobs
                }
            }
            .padding(.horizontal)
            .background(Color(.secondarySystemBackground), ignoresSafeAreaEdges: .all)
        }
        .sheet(isPresented: $showDetailView) {
            JobDetailView(isPresented: $showDetailView)
        }
        .preferredColorScheme(colorScheme)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

private extension HomeView {
    var jobsAdvertsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0 ..< 10) { item in
                    JobAdvertView(item)
                    .padding(6)
                    .background(item%2 == 0 ? Color.white : Color(.systemBackground))
                    .cornerRadius(10)
                }
            }
        }
    }
    var recentPostedJobs: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Section {
                ForEach(0 ..< 5) { item in
                    JobRowView()
                }
            } header: {
                Text("Recently Posted")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
