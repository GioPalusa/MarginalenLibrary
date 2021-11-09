//
//  ProgressStepView.swift
//  Marginalen
//
//  Created by michaelst on 2021-06-04.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

// MARK: - ProgressStepView

struct ProgressStepView: View {
    var currentStep: Int
    var totalSteps: Int
    var visitedStepColor = Color(UIColor.MarginalenColors.primaryRed.color)
    var unvisitedStepColor = Color(UIColor.MarginalenColors.lightBlueGrey.color)

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< totalSteps) { step in
                let color = step < currentStep ? visitedStepColor : unvisitedStepColor
                SingleStepView(color: color)
                    .padding(1)
            }
        }
        .padding(.horizontal, 2)
    }
}

// MARK: - SingleStepView

struct SingleStepView: View {
    var color: Color

    var body: some View {
        Rectangle()
            .frame(maxHeight: 4)
            .cornerRadius(2)
            .foregroundColor(color)
    }
}

// MARK: - ProgressStepView_Previews

struct ProgressStepView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressStepView(currentStep: 4, totalSteps: 8)
    }
}
