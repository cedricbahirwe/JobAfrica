//
//  JobAdvertView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct JobAdvertView: View {
    let item: Int
    init(_ item: Int = 1) {
        self.item = item
    }
    private var imageName: String {
        let img = item < 6 ? item+1 : 1
        return "img\(img)"
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Image(imageName)
                    .resizable()
                    .cornerRadius(5)
                    .padding(4)
                    .frame(width: 35, height: 35)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)

                Spacer()

                Text("Part time")
                    .font(.caption)
                    .padding(4)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(10)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.white)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Graphic Design")
                    .fontWeight(.semibold)

                Text("Solid Design")
                    .font(.system(.caption))
                    .opacity(0.9)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .foregroundColor(.white)
        }
        .padding(10)
        .frame(width: 130, height: 130)
        .background(Image("img1").resizable())
        .cornerRadius(10)
    }
}

struct JobAdvertView_Previews: PreviewProvider {
    static var previews: some View {
        JobAdvertView()
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Color.red)
    }
}
