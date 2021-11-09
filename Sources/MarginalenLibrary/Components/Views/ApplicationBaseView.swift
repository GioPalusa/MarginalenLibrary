//
//  ApplicationBaseView.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-08-17.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct ApplicationBaseView<Content: View>: View {
    let titleText: String
    let bodyText: String
    let currentStep: Int
    let totalSteps: Int
    let inEditingMode: Bool

    var content: () -> Content

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ProgressStepView(currentStep: currentStep, totalSteps: totalSteps)
                    .hidden(inEditingMode)

                VStack(spacing: 0) {
                    InfoTextView(titleText: Text(titleText),
                                 bodyText: Text(bodyText))
                    content()
                }
            }
            .padding(.top, 32)
            .padding(.bottom, 150)
        }
        .background(Color.marginalen(color: .veryLightPink))
    }
}

struct ApplicationBaseView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationBaseView(titleText: "Title", bodyText: "Body", currentStep: 2, totalSteps: 7, inEditingMode: false) {
            VStack {
                Text("Test").foregroundColor(.black)
            }
        }
    }
}
