//
//  HomeView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct HomeView: View {
    @State private var colorScheme: ColorScheme? = nil
    @State private var selectedJobTag: JobTags = JobTags.all
    @State private var showDetailView = false
    @State private var showMenu: Bool = false
    private let screenSize = UIScreen.main.bounds.size

    var body: some View {
        ZStack {
            VStack {

                NavigationBarView(
                    onMenu: {
                        withAnimation {
                            showMenu.toggle()
                        }
                    },
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
            .rotation3DEffect(.degrees(showMenu ? 45 : 0),
                              axis: (0,3,0),
                              anchor: .leading,
                              anchorZ: 1,
                              perspective: 1)
            .offset(x: showMenu ? screenSize.width*0.8 : 0)
            .disabled(showMenu)

            MainMenuView(isPresented: $showMenu, screenSize: screenSize)
        }
        .sheet(isPresented: $showDetailView) {
            JobDetailView(isPresented: $showDetailView)
        }
        .preferredColorScheme(.dark)
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
                        .background(.ultraThickMaterial)
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
                        .onTapGesture {
                            showDetailView.toggle()
                        }
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


public enum AppTheme: String, CaseIterable {
    case light, dark, system

    public var colorScheme: ColorScheme? {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
}
