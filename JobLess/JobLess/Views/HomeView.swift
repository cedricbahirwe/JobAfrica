//
//  HomeView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var jobStoreManager = JobStoreManager()

    @State private var selectedJob: Job?
    @State private var selectedJobTag: JobTag = .all
    @State private var showMenu: Bool = false
    @State private var showSearch: Bool = false
    @State private var searchEntry: String = ""

    private let screenSize = UIScreen.main.bounds.size

    private var filteredJobs: [Job] {
        selectedJobTag == .all ?
        jobStoreManager.generalJobs :
        jobStoreManager.generalJobs.filter({ $0.title.lowercased() == searchEntry.lowercased() })
    }

    @StateObject var sheetStore = GoogleSheetsAPI()
    var body: some View {
        ZStack {
            VStack {
                NavigationBarView(
                    onMenu: {
                        withAnimation {
                            showMenu.toggle()
                        }
                    },
                    onSearch: {
                        showSearch.toggle()
                    },
                    onFilter: {})
                .padding(.horizontal)
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 20, pinnedViews: .sectionHeaders) {
                        Text("Find a job for you\n\(Text("in Africa 🌍").bold())")
                            .font(.system(.title, design: .rounded))
                            .layoutPriority(2)
                            .padding(.horizontal)
                        
                        if !jobStoreManager.promoJobs.isEmpty {
                            jobsAdvertsView
                        }
                        
                        Section {
                            recentPostedJobs
                        } header: {
                            JobTagsView(jobStoreManager.jobTags, selection: $selectedJobTag)
                        }
                    }
                }
            }
            .background(Color(.secondarySystemBackground), ignoresSafeAreaEdges: .all)
            .rotation3DEffect(.degrees(showMenu ? 45 : 0),
                              axis: (0,1,0))
            .offset(x: showMenu ? screenSize.width*0.8 : 0)
            .disabled(showMenu)

//            JobSearchView(searchEntry: $searchEntry, isPresented: $showSearch)
//                .scaleEffect(showSearch ? 1 : 0.1 , anchor: .topTrailing)
//                .cornerRadius(showSearch ?  0 : CGFloat.infinity)
//                .animation(.easeInOut(duration: 0.3), value: showSearch)
//                .offset(x: showSearch ? 0 : -80)
//                .allowsHitTesting(showSearch)

            SettingsView(isPresented: $showMenu, screenSize: screenSize)

            AppLaunchView(jobStoreManager.isLoading, 0.9)
        }
        .fullScreenCover(item: $selectedJob,
               content: JobDetailView.init)
        .environmentObject(jobStoreManager)
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
#endif

private extension HomeView {
    var jobsAdvertsView: some View {
        VStack(alignment: .leading) {
            Text("Trending ")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(jobStoreManager.promoJobs) { job in
                        JobAdvertView(job)
                            .padding(.trailing)
                            .onTapGesture {
                                selectedJob = job
                            }
                    }
                }
                .padding(.leading)
            }
        }
    }
    
    var recentPostedJobs: some View {
        VStack(alignment: .leading) {
            Text("Recently Posted")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 15) {
                ForEach(filteredJobs) { job in
                    JobRowView(job)
                        .onTapGesture {
                            selectedJob = job
                        }
                }
            }
        }
        .padding(.horizontal)
    }
}
