//
//  SliderView.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-07-07.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct SliderView: View {
    @Binding var sliderValue: Double
    @Binding var trailingText: String

    var clickableTrailingText = false
    var formatter: Formatter = SwedishCrownsFormatter.standard
    let leadingText: String
    let minimumValue: Float
    let maximumValue: Float
    let step: Float
    let thumbColor: UIColor = UIColor.MarginalenColors.greenyBlue.color
    let minTrackColor: UIColor? = UIColor.MarginalenColors.greenyBlue.color
    let maxTrackColor: UIColor? = UIColor.MarginalenColors.paleAqua.color
    var didBeginEditing: (() -> Void)?
    var didEndEditing: (() -> Void)?

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(leadingText)
                    .font(font: .smallText)
                Spacer()
                if clickableTrailingText {
                    TextFieldView(text: $trailingText,
                                  keyboardType: .numberPad,
                                  font: .title,
                                  alignment: .right,
                                  didBeginEditing: didBeginEditing,
                                  didEndEditing: didEndEditing)

                } else {
                    Text($trailingText.wrappedValue)
                        .font(font: .title)
                }
            }
            CustomSlider(value: $sliderValue,
                         minimumValue: minimumValue,
                         maximumValue: maximumValue,
                    step: step,
                         thumbColor: thumbColor,
                         minTrackColor: minTrackColor,
                         maxTrackColor: maxTrackColor)
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SliderView(sliderValue: .constant(0.5),
                       trailingText: .constant("100 000 kr"),
                       leadingText: "Lånebelopp",
                       minimumValue: 0,
                       maximumValue: 1,
                       step: 0.1)

            SliderView(sliderValue: .constant(0.5),
                       trailingText: .constant("100 000 kr"),
                       clickableTrailingText: true,
                       leadingText: "Lånebelopp",
                       minimumValue: 0,
                       maximumValue: 1,
                       step: 0.1)
        }
        .previewLayout(.fixed(width: 375, height: 150))
    }
}
