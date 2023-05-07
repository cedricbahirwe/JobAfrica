//
//  JobTagsView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct JobTagsView: View {
    init(_ tags: [JobTag], selection: Binding<JobTag>) {
        self.tags = tags
        _selection = selection
    }

    private let tags: [JobTag]
    @Binding var selection: JobTag
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(tags, id:\.rawValue) { tag in
                    Text(tag.formatted)
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .colorInvert()
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(selection == tag ? Color.cyan : Color.primary)
                        .clipShape(Capsule())
                        .onTapGesture {
                            withAnimation {
                                selection = tag
                            }
                        }
                }
            }
            .padding(.leading)
        }
    }
}

#if DEBUG
struct JobTagsView_Previews: PreviewProvider {
    static var previews: some View {
        JobTagsView(JobTag.allCases, selection: .constant(.all))
    }
}
#endif
