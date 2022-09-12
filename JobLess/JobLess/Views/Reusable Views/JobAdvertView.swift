//
//  JobAdvertView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct JobAdvertView: View {
    let job: Job
    init(_ job: Job) {
        self.job = job
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
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
                    .frame(width: 40, height: 40)
                    .clipped()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                } else {
                    Image("company.logo.placeholder")
                        .resizable()
                        .cornerRadius(5)
                        .padding(6)
                        .frame(width: 40, height: 40)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)

                }
                Spacer()

                Text(job.type.rawValue.capitalized)
                    .font(.caption)
                    .padding(4)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(10)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.white)
            }
            .frame(maxHeight: .infinity, alignment: .top)

            VStack(alignment: .leading, spacing: 4) {
                Text(job.title)
                    .fontWeight(.semibold)

                Text(job.company.name)
                    .font(.system(.callout))
                    .opacity(0.9)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.white)
        }
        .padding(10)
        .frame(width: 150, height: 150)
        .background(
            ZStack {
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
                } else {
                    Image("img1")
                        .resizable()
                        .opacity(0.8)
                }
            }
        )
        .cornerRadius(10)
    }
}

#if DEBUG
struct JobAdvertView_Previews: PreviewProvider {
    static var previews: some View {
        JobAdvertView(.customerService)
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Color.red)
    }
}
#endif
