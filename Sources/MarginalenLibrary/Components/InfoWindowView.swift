//
//  InfoWindowView.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-04-28.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI
#if !os(macOS)
import UIKit
#endif

// MARK: - InfoWindowViewModel

@available(iOS 13.0, *)
class InfoWindowViewModel: ObservableObject {
    // MARK: Lifecycle

    init(title: String, body: String) {
        self.title = title
        self.body = body
    }

    // MARK: Internal

    @Published var title: String
    @Published var body: String
}

// MARK: - InfoWindowView

/// When using in a scrollView, make sure to use: `.fixedSize(horizontal: false, vertical: true)` to avoid text being cropped.
@available(iOS 13.0, *)
struct InfoWindowView: View {
    @ObservedObject var viewModel: InfoWindowViewModel
    var verticalPadding: CGFloat = 32

    var body: some View {
        VStack(spacing: 16) {
            Text(viewModel.title)
                .font(font: .largeTitle)
                .foregroundColor(Color(UIColor.MarginalenColors.primaryRed.color))
                .multilineTextAlignment(.center)
            Text(viewModel.body)
                .font(font: .body)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .padding(.vertical, verticalPadding)
        .background(Color.secondarySystemGroupedBackground)
    }
}

// MARK: - InfoWindowView_Previews
@available(iOS 13.0, *)
struct InfoWindowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            InfoWindowView(viewModel: InfoWindowViewModel(title: "Härligt!",
                                                          body: "Just nu finns det inget att betala, njut av en tom lista")).padding(.top, 16)

            InfoWindowView(viewModel: InfoWindowViewModel(title: "Vi har uppdaterad din faktura",
                                                          body: "Din betalning som skulle varit oss tillhanda den 26:e har inte genomförts. Kontrollera ditt autogiro med din bank. Vänligen betala omgående den missade avin"))
            Spacer()
        }.background(Color.gray)
    }
}
