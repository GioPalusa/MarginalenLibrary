//
//  ValidationModifier.swift
//  Marginalen
//
//  Created by michaelst on 2021-04-15.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct ValidationModifier: ViewModifier {

    @State var latestValidation: Validation = .success

    let validationPublisher: ValidationPublisher

    func body(content: Content) -> some View {
        return VStack(alignment: .leading, spacing: 0) {
            content
            validationMessage
        }.onReceive(validationPublisher) { validation in
            withAnimation {
                self.latestValidation = validation
            }
        }
    }

    var validationMessage: some View {
        switch latestValidation {
        case .success:
            return AnyView(EmptyView())
        case .failure(let message):
            let errorView = ErrorMessageView(errorMessage: message)
            return AnyView(errorView)
        }
    }
}
