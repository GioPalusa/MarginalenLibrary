//
//  CustomSlider.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-07-06.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI
#if !os(macOS)
import UIKit
#endif

@available(iOS 13.0, *)
class CustomUISlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 8.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
}

@available(iOS 13.0, *)
struct CustomSlider: UIViewRepresentable {
    @Binding var value: Double

    var minimumValue: Float
    var maximumValue: Float
    var step: Float
    var thumbColor: UIColor = UIColor.MarginalenColors.greenyBlue.color
    var minTrackColor: UIColor? = UIColor.MarginalenColors.greenyBlue.color
    var maxTrackColor: UIColor? = UIColor.MarginalenColors.paleAqua.color

    func makeUIView(context: Context) -> CustomUISlider {
        let slider = CustomUISlider(frame: .zero)
        slider.thumbTintColor = thumbColor
        slider.minimumTrackTintColor = minTrackColor
        slider.maximumTrackTintColor = maxTrackColor
        slider.value = round(Float(self.value) / step) * step
        slider.minimumValue = minimumValue
        slider.maximumValue = maximumValue

        slider.addTarget(context.coordinator,
                         action: #selector(Coordinator.valueChanged(_:)),
                         for: .valueChanged)

        return slider
    }

    func updateUIView(_ uiView: CustomUISlider, context: Context) {
        let roundedValue = round(Float(self.value) / step) * step
        uiView.value = roundedValue
    }

    func makeCoordinator() -> CustomSlider.Coordinator {
        Coordinator(value: $value, step: step)
    }
}

// MARK: - Coordinator
extension CustomSlider {
    final class Coordinator: NSObject {
        let step: Double
        var value: Binding<Double>

        init(value: Binding<Double>, step: Float) {
            self.value = value
            self.step = Double(step)
        }

        @objc func valueChanged(_ sender: CustomUISlider) {
            self.value.wrappedValue = round(Double(sender.value) / step) * step
        }
    }
}

struct CustomSlider_Previews: PreviewProvider {
    static var previews: some View {
        CustomSlider(value: .constant(50000),
                     minimumValue: 50000,
                     maximumValue: 500000,
                     step: 1000)
    }
}
