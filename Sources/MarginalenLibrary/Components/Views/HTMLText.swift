//
//  HTMLText.swift
//  Marginalen
//
//  Created by michaelst on 2021-04-22.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//
import SwiftUI

struct HTMLText: UIViewRepresentable {
    let text: String
    let fontSize: CGFloat
    let color: UIColor? = UIColor.label
    @Binding var dynamicHeight: CGFloat

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        DispatchQueue.main.async {
            let lineHeight: CGFloat = 1.8
            if let attributedText = self.text.htmlAttributed(lineHeight: lineHeight, fontSize: fontSize, color: color ?? UIColor.label) {
                uiView.attributedText = attributedText
            }
            dynamicHeight = uiView.sizeThatFits(CGSize(width: uiView.bounds.width, height: CGFloat.greatestFiniteMagnitude)).height
        }
    }
}
