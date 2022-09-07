//
//  JobRowView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct JobRowView: View {
    var body: some View {
        HStack {
            Image("img6")
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipped()
                .cornerRadius(8)


            VStack(alignment: .leading, spacing: 0) {
                Text("iOS Developer")
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.semibold)

                Spacer()

                Text("ABC Bank")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)

            Text("BHD - p/m")
                .font(.system(.caption, design: .rounded))
                .foregroundColor(.secondary)
        }
        .padding(10)
        .background(Color.foreground)
        .cornerRadius(10)
    }
}


struct JobRowView_Previews: PreviewProvider {
    static var previews: some View {
        JobRowView()
    }
}
