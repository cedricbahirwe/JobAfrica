//
//  JobTagsView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct JobTagsView: View {
    init(_ tags: [JobTags], selection: Binding<JobTags>) {
        self.tags = tags
        _selection = selection
    }

    private let tags: [JobTags]
    @Binding var selection: JobTags

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(tags, id:\.rawValue) { tag in
                    Text(tag.formatted)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(selection == tag ? Color.white : Color.foreground)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(selection == tag ? Color.indigo : Color.primary)
                        .cornerRadius(8)
                        .onTapGesture {
                            withAnimation {
                                selection = tag
                            }
                        }
                }
            }
        }
    }
}

struct JobTagsView_Previews: PreviewProvider {
    static var previews: some View {
        JobTagsView(JobTags.allCases, selection: .constant(.all))
    }
}
