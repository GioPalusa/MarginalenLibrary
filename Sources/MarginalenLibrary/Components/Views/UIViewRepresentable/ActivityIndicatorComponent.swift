//
//  ActivityIndicatorComponent.swift
//  Marginalen
//
//  Created by michaelst on 2021-03-18.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//
import SwiftUI

struct ActivityIndicatorComponent: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView

    @State var isAnimating: Bool
    var color: UIColor? = .white
    var style: UIActivityIndicatorView.Style = .medium

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorComponent>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorComponent>) {
        uiView.hidesWhenStopped = true
        uiView.style = style
        uiView.color = color
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
