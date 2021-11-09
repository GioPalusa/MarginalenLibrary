//
//  DetailsView.swift
//  Marginalen
//
//  Created by michaelst on 2021-03-16.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

// MARK: - DetailsView

struct DetailsView<DestinationView: View>: View {
    var title: String
    var destination: DestinationView?

    var body: some View {
        NavigationLink(destination: destination) {
            HStack(alignment: .center) {
                Text(title)
                    .padding(.leading, 16)
                    .foregroundColor(Color(UIColor.label))
                    .font(font: .title)
                Spacer()
                Image("Right Detail")
                    .renderingMode(.template)
                    .foregroundColor(Color(UIColor.MarginalenColors.primaryRed.color))
                    .padding(.trailing, 19)
            }.frame(height: 58, alignment: .center)
                .background(Color(UIColor.secondarySystemGroupedBackground))
        }.buttonStyle(PlainButtonStyle())
    }
}

// MARK: - DetailsView_Previews

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let title = "Title"
        let url = "https://online.marginalen.se"
        DetailsView(title: title,
                    destination:
                        SafariViewComponent(url: URL(string: url)!).navigationBarTitle(title))
    }
}
