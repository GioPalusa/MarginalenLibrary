//
//  ErrorMessageView.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2021-03-17.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct ErrorMessageView: View {

    let message: String

    init(errorMessage: String) {
        self.message = errorMessage
    }

    var body: some View {
        HStack {
            Image("badge_error")
            Text(message)
                .font(font: .regularButtonText)
                .lineLimit(nil)
                .padding(.vertical, 16)
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(Color(UIColor.MarginalenColors.veryLightPinkTwo.color))
    }
}

struct ErrorMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessageView(errorMessage: "Fyll i hela ditt namn")
    }
}
