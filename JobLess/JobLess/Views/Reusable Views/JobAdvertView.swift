//
//  JobAdvertView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct JobAdvertView: View {
    let item: Int
    init(_ item: Int) {
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
                    .background(.ultraThickMaterial)
                    .cornerRadius(10)

                Spacer()

                Text("Part time")
                    .font(.caption)
                    .lineLimit(1)
                    .padding(4)
                    .background(.background)
                    .cornerRadius(4)
                    .minimumScaleFactor(0.5)
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
    }
}
