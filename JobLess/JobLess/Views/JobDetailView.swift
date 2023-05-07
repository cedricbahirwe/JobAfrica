//
//  JobDetailView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct JobDetailView: View {
    private let job: Job
    init(_ job: Job) {
        self.job = job
    }
    @EnvironmentObject private var jobStoreManager: JobStoreManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            AppGradient.main.ignoresSafeArea(edges: .top)
                .frame(height: UIScreen.main.bounds.height*0.2)
                .overlay(alignment: .bottom) {
                    Color.gray.frame(height: 2)
                }
                .overlay(alignment: .bottomLeading) {
                    AsyncImage(url: job.company.logoURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image("company.logo.placeholder")
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(width: 80, height: 80)
                    .background(.ultraThickMaterial)
                    .cornerRadius(20)
                    .shadow(color: .gray, radius: 2)
                    .offset(y: 40)
                    .padding(.leading, 20)
                }
                .overlay(alignment: .topLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .scaledToFit()
                            .padding(12)
                            .frame(width: 45)
                            .foregroundColor(.white)
                            .overlay {
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding()
                }
                .zIndex(20)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Label(job.postDate.formatted(date: .long, time: .omitted), systemImage: "calendar")
                        .font(.callout.weight(.semibold))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.vertical, 20)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading) {
                            Text(job.company.name)
                                .font(.title3)
                                .opacity(0.8)
                            
                            Text(job.title)
                                .font(.title)
                                .fontWeight(.semibold)
                        }
                        
                        Text("Description")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        VStack(alignment: .leading) {
                            ForEach(job.description.paragraphs, id: \.self) { paragraph in
                                Group {
                                    if let title = paragraph.head {
                                        Text(title)
                                            .font(.system(.title))
                                            .foregroundColor(.primary)
                                    }
                                    
                                    if let body = paragraph.body {
                                        Text(body)
                                            .opacity(0.7)
                                            .minimumScaleFactor(0.9)
                                    }
                                }
                            }
                            
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 20) {
                                    Text("\(job.type.rawValue.capitalized) - \(job.category.rawValue.capitalized)")
                                        .font(.system(.caption, design: .rounded))
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                                .background(Color.darkerBackground)
                                .cornerRadius(20)
                            }
                            
                            VStack(alignment: .leading, spacing: 20) {
                                
                                if let email = job.contact?.email {
                                    ContactLabel("Email Address", email)
                                }
                                
                                if let whatsapp = job.contact?.whatsapp {
                                    ContactLabel("WhatsApp Number", whatsapp)
                                }
                                
                                if let telegram = job.contact?.telegram {
                                    ContactLabel("Telegram:", "@\(telegram)")
                                }
                            }
                            .padding(.vertical, 10)
                        }
                    }
                    
                    lazy var randomColor: Color = [.mint, .main, .teal, .cyan, .orange, .green, .yellow, .indigo, .blue, .pink].randomElement()!

                    Link(destination: job.jobLink) {
                        Label("Apply Now", systemImage: "link")
                            .labelStyle(.titleOnly)
                            .font(.system(.body).weight(.bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(randomColor)
                            .cornerRadius(15)
                    }
                }
                .padding(.horizontal, 20)
            }
            .zIndex(10)
        }
        .task {
            do {
                try await jobStoreManager.viewJob(job)
            } catch {
                print(error)
            }
        }
    }
}

#if DEBUG
struct JobDetailView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailView(.customerService)
            .environmentObject(JobStoreManager())
//            .preferredColorScheme(.dark)
    }
}
#endif

extension JobDetailView {
    struct ContactLabel: View {
        private let key: String
        private let value: String
        init(_ key: String, _ value: String) {
            self.key = key
            self.value = value
        }

        var body: some View {
            HStack {
                Text("\(key):").bold()
                Text(value)
                    .foregroundColor(.main)
            }
        }
    }
}
