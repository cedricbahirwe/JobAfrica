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
        JobItemView(job: job, isExpanded: false)
            .padding(20)
            .frame(width: 260, height: 190)
            .background(AppGradient.mainGradient)
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

struct JobItemView: View {
    let job: Job
    let isExpanded: Bool
    
    private var imageSize: CGFloat {
        isExpanded ? 55 : 40
    }
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                AsyncImage(url: job.company.logoURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image("company.logo.placeholder")
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: imageSize, height: imageSize)
                .clipped()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                
                Spacer()
                
                Label(job.postDate.formatted(date: isExpanded ? .abbreviated : .numeric, time: .omitted), systemImage: "calendar")
                    .font(.callout.weight(.semibold))
                    .foregroundColor(.white)
                    .opacity(0.7)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.vertical, 20)
                
//                Button {
//                } label: {
//                    Image(systemName: "bookmark")
//                        .resizable()
//                        .scaledToFit()
//                        .padding(6)
//                        .frame(width: 30, height: 30)
//                        .overlay {
//                            Circle().stroke(Color.accentColor, lineWidth: 1)
//                        }
//                }
//                .hidden()
            }
            .frame(maxHeight: isExpanded ? nil : .infinity, alignment: .top)

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
            
            if isExpanded, let description = job.miniDescription {
                Text(description)
                    .lineLimit(3)
                    .minimumScaleFactor(0.9)
                    .foregroundColor(.white)
                    .opacity(0.7)
                    .padding(.top, 6)
            }
        }
    }
}
