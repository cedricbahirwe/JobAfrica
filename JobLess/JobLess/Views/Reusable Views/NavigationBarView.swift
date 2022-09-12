//
//  NavigationBarView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct NavigationBarView: View {
    var onMenu: () -> Void
    var onSearch: () -> Void
    var onFilter: () -> Void

    var body: some View {
        HStack(spacing: 20) {
            navBarButton("line.3.horizontal.decrease",
                         alignment: .leading,
                         action: onMenu)

            Spacer()

            navBarButton("magnifyingglass", action: onSearch)

//            navBarButton("slider.horizontal.3", action: onFilter)
        }
    }

    @ViewBuilder
    private func navBarButton(_ image: String,
                              alignment: Alignment = .center,
                              action: @escaping() -> Void) -> some View {
        Image(systemName: image)
            .imageScale(.large)
            .frame(width: 30, height: 30, alignment: alignment)
            .contentShape(Rectangle())
            .onTapGesture(perform: action)
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView(onMenu: {},
                          onSearch: {},
                          onFilter: {})
        .background(Color.blue)
        .previewLayout(.sizeThatFits)
    }
}
