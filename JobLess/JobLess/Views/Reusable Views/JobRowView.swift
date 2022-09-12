//
//  JobRowView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct JobRowView: View {
    let job: Job
    init(_ job: Job) {
        self.job = job
    }

    var body: some View {
        HStack {
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
                .frame(width: 50, height: 50)
                .clipped()
                .cornerRadius(8)
            } else {
                Image("company.logo.placeholder")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipped()
                    .cornerRadius(8)
            }


            VStack(alignment: .leading, spacing: 8) {
                Text(job.title)
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.semibold)

                HStack {
                    Text(job.company.name)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.secondary)

                    Spacer(minLength: 1)

                    Text("\(job.type.rawValue.capitalized) - \(job.category.rawValue)")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.secondary)
                }
                .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(10)
        .background(Color.foreground)
        .cornerRadius(10)
    }
}

#if DEBUG
struct JobRowView_Previews: PreviewProvider {
    static var previews: some View {
        JobRowView(.customerService)
    }
}
#endif
