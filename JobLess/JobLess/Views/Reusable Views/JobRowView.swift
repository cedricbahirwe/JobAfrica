//
//  JobRowView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct JobRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    let job: Job
    init(_ job: Job) {
        self.job = job
    }

    var body: some View {
        JobItemView(job: job, isExpanded: true)
            .padding(20)
            .frame(maxWidth: .infinity)        
            .background(
                colorScheme == .light ?
                Color(red: 37/255, green: 40/255, blue: 42/255) :
                    Color.darkerBackground
            )
            .cornerRadius(20)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color.gray.opacity(0.75), lineWidth: 1.5)
            }
    }
}

#if DEBUG
struct JobRowView_Previews: PreviewProvider {
    static var previews: some View {
        JobRowView(.customerService)
            .padding()
            .previewLayout(.sizeThatFits)
//            .preferredColorScheme(.dark)
    }
}
#endif
