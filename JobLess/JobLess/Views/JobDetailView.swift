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
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "x.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundColor(.primary)
                }
                Spacer()
            }
            VStack(spacing: 12) {
                if let logoURL = job.company.logoURL {
                    AsyncImage(url: logoURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image("company.logo.placeholder")
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(width: 150, height: 150)
                    .clipped()
                    .cornerRadius(20)
                } else {
                    Image("company.logo.placeholder")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .cornerRadius(20)
                }

                Text(job.title)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.semibold)

                Text(job.location)
                    .font(.system(.title2, design: .monospaced).weight(.semibold))

                Text(job.postDate, style: .date)
                    .font(.system(.callout).weight(.semibold))
                    .foregroundColor(.secondary)
            }

            VStack {
                Text("Job Description")
                    .font(.system(.title2, design: .monospaced).weight(.semibold))
                    .padding(.top)
                ScrollView(.vertical, showsIndicators: false) {
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
                                        .font(.system(.title3))
                                        .foregroundColor(.secondary)
                                        .minimumScaleFactor(0.9)
                                }
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 20) {

                    if let email = job.contact?.email {
                        ContactLabel("Email Address", email)
                    }

                    if let whatsapp = job.contact?.whatsapp {
                        ContactLabel("WhatsApp Number", whatsapp)
                    }


                    Link(destination: job.jobLink) {
                        Label("Apply Now", systemImage: "link")
                            .labelStyle(.titleOnly)
                            .font(.system(.body).weight(.bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.main)
                            .cornerRadius(15)
                    }
                }
            }

        }
        .padding()
        .background(Color(.secondarySystemBackground), ignoresSafeAreaEdges: .all)
    }
}

#if DEBUG
struct JobDetailView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailView(.customerService)
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
