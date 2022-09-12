//
//  HomeView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var jobStoreManager = JobStoreManager()
    @State private var jobTags = [JobTag]()

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

                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        if selectedJobTag == .all {
                            Text("Find a job for you\n\(Text("in Africa 🌍").bold())")
                        } else {
                            Text(selectedJobTag.formatted)
                        }
                    }
                    .font(.system(.title, design: .rounded))
                    .layoutPriority(2)
                    
                    jobsAdvertsView
                    
                    JobTagsView(jobTags, selection: $selectedJobTag)
                    
                    recentPostedJobs
                }
            }
            .padding(.horizontal)
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
        }
        .sheet(item: $selectedJob,
               content: JobDetailView.init)
        .onAppear(perform: initialization)
        .environmentObject(jobStoreManager)
    }

    private func initialization() {
        // Save User or update existing User
        try? jobStoreManager.saveUser(.getMetadata())
        jobStoreManager.saveJob(.example, isPromo: true)
        // Load General Jobs
        jobStoreManager.loadJobs {
            jobStoreManager.generalJobs = $0.map({ $0.toDomainModel() })
        }

        // Load Promo Jobs
        jobStoreManager.loadJobs(isPromos: true) {
            jobStoreManager.promoJobs = $0.map({ $0.toDomainModel() })
        }

        jobStoreManager.loadTags {
            self.jobTags = $0.map({ $0.toDomainModel() }).sorted(by: { $0.rawValue < $1.rawValue})
        }
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
                        .padding(8)
                        .background(.ultraThickMaterial)
                        .cornerRadius(10)
                        .onTapGesture {
                            selectedJob = job
                        }
                }
            }
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
    }
}
