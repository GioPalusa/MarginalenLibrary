//
//  DividerArrowView.swift
//  Marginalen
//
//  Created by michaelst on 2021-06-04.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

// MARK: - DividerArrowView

struct DividerArrowView: View {
    var color = Color(UIColor.MarginalenColors.lightBlueGrey.color)

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            Arrow(width: width)
                .stroke(lineWidth: 0.5)
                .foregroundColor(color)
        }
    }
}

// MARK: - Arrow

struct Arrow: Shape {
    let width: CGFloat

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addLines([
                CGPoint(x: 0, y: 0),
                CGPoint(x: 20, y: 0),
                CGPoint(x: 30, y: -10),
                CGPoint(x: 40, y: 0),
                CGPoint(x: width, y: 0)
            ])
        }
    }
}

// MARK: - DividerArrowView_Previews

struct DividerArrowView_Previews: PreviewProvider {
    static var previews: some View {
        DividerArrowView()
    }
}
