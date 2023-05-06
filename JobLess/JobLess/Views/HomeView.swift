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
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Find a job for you\n\(Text("in Africa 🌍").bold())")
                        .font(.system(.title, design: .rounded))
                        .layoutPriority(2)
                        .padding(.horizontal)
                    
                    jobsAdvertsView
                    
                    JobTagsView(jobStoreManager.jobTags, selection: $selectedJobTag)
                    
                    recentPostedJobs
                }
            }
            .rotation3DEffect(.degrees(showMenu ? 45 : 0),
                              axis: (0,3,0),
                              anchor: .leading,
                              anchorZ: 1,
                              perspective: 1)
            .offset(x: showMenu ? screenSize.width*0.8 : 0)
            .disabled(showMenu)
            .background(Color(.secondarySystemBackground), ignoresSafeAreaEdges: .all)

            JobSearchView(searchEntry: $searchEntry, isPresented: $showSearch)
                .scaleEffect(showSearch ? 1 : 0.1 , anchor: .topTrailing)
                .cornerRadius(showSearch ?  0 : CGFloat.infinity)
                .animation(.easeInOut(duration: 0.3), value: showSearch)
                .offset(x: showSearch ? 0 : -80)
                .allowsHitTesting(showSearch)

            MainMenuView(isPresented: $showMenu, screenSize: screenSize)

            LaunchView(jobStoreManager.isLoading, 0.9)
        }
        .fullScreenCover(item: $selectedJob,
               content: JobDetailView.init)
        .environmentObject(jobStoreManager)
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
    var recentPostedJobs: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Section {
                ForEach(filteredJobs) { job in
                    JobRowView(job)
                        .onTapGesture {
                            selectedJob = job
                        }
                }
            } header: {
                Text("Recently Posted")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal)
    }
}
//rgba(15,21,27,255)
