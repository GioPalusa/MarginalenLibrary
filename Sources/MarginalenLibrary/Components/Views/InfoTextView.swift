//
//  InfoTextView.swift
//  Marginalen
//
//  Created by michaelst on 2021-03-15.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct InfoTextView: View {
    var titleText: Text
    var bodyText: Text
    var paddingTop: CGFloat = 16

    var body: some View {
        VStack(spacing: 0) {
            titleText
                .foregroundColor(.marginalen(color: .primaryRed))
                .font(font: .largeTitle)
                .multilineTextAlignment(.center)
                .animation(nil)
                .padding(.bottom, 16)
            HStack {
                Spacer()
                bodyText
                    .font(font: .body)
                    .multilineTextAlignment(.center)
                    .lineSpacing(8)
                    .fixedSize(horizontal: false, vertical: true)
                    .animation(nil)
                Spacer()
            }
        }
        .padding(.vertical, 32)
        .padding(.horizontal, 32)
        .background(Color(UIColor.secondarySystemGroupedBackground))
    }
}

struct InfoTextView_Previews: PreviewProvider {
    static var previews: some View {
        InfoTextView(titleText: Text("Title"), bodyText: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."))
            .previewLayout(.fixed(width: 375, height: 400))
    }
}
