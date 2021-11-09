//
//  InformationSecondaryView.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2021-09-09.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct InformationSecondaryView: View {
    var infoLeft: String
    var infoRight: String
    var showTopDivider: Bool = false
    var showBottomDivider: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            if showTopDivider { Divider() }
            HStack(alignment: .top) {
                Text(infoLeft).font(font: .title).layoutPriority(1)
                Spacer()
                Text(infoRight)
                    .trailingAlignment()
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .frame(height: 88)
            if showBottomDivider { Divider() }
        }
    }
}

struct InformationSecondaryView_Previews: PreviewProvider {
    static var previews: some View {
        InformationSecondaryView(infoLeft: "Left label", infoRight: "Right label", showTopDivider: true, showBottomDivider: true)
    }
}
