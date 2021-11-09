//
//  PlainCell.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-25.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct PlainCell<Destination: View>: View {
    let text: String
    let image: Image?
    let destination: Destination
    let deviceRatio: CGFloat = UIDevice.current.isSmall ? 0.7 : 1
    private var font: Font.Marginalen = .title

    init(text: String,
         image: Image? = nil,
         destination: Destination) {
        self.text = text
        self.image = image
        self.destination = destination
    }

    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 16) {
                if let image = image {
                    image
                        .foregroundColor(.marginalen(color: .primaryRed))
                        .fixedSize()
                        .frame(width: 24)
                }
                Text(text)
                    .font(font: font)
                    .foregroundColor(.label)
                Spacer()
                Icon(.rightChevron)
                    .foregroundColor(.marginalen(color: .primaryRed))
            }.padding(.horizontal, 16)
            .padding(.vertical, 26 * deviceRatio)
        }
    }
}

struct PlainCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlainCell(text: "Så behandlas dina personuppgifter", image: nil, destination: Text(""))
            PlainCell(text: "Random title", image: Image("icon_tabbar_card"), destination: Text(""))
        }.previewLayout(.fixed(width: 375, height: 70))
    }
}
