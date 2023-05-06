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
                
                Button {
                    
                } label: {
                    Image(systemName: "bookmark")
                        .resizable()
                        .scaledToFit()
                        .padding(6)
                        .frame(width: 30, height: 30)
                        .overlay {
                            Circle().stroke(Color.accentColor, lineWidth: 1)
                        }
                }
                .hidden()
            }
            .frame(maxHeight: .infinity, alignment: .top)

            VStack(alignment: .leading) {
                Text(job.company.name)
                    .font(.system(.callout))
                    .opacity(0.9)
                
                Text(job.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.9)

                JobAdvertTag(tile: job.type.rawValue.capitalized)
               
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.white)
        }
        .padding(20)
        .frame(width: 260, height: 170)
        .background(AppGradient.main)
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.gray.opacity(0.75), lineWidth: 1.5)
        }
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


enum AppGradient {
    static var main: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 13/255, green: 29/255, blue: 79/255),
                Color(red: 13/255, green: 22/255, blue: 36/255),
                Color(red: 28/255, green: 75/255, blue: 102/255),
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    
    static var applyBackground: Color {
        Color.red
    }
}

struct JobAdvertTag: View {
    let tile: String
    var body: some View {
        Text(tile)
            .font(.callout.weight(.medium))
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(.white)
            .clipShape(Capsule())
            .foregroundColor(.black)
            .lineLimit(1)
    }
}
