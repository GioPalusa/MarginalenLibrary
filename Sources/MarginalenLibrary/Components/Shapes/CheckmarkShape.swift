//
//  CheckmarkShape.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-10-12.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

/// Ratio - Width: 15, Height: 13
struct CheckmarkShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path {
            $0.move(to: .init(x: rect.maxX * 0.363, y: rect.maxY * 0.805))
            $0.addLine(to: .init(x: rect.maxX * 0.142, y: rect.maxY * 0.518))
            $0.addLine(to: .init(x: rect.maxX * 0.066, y: rect.maxY * 0.615))
            $0.addLine(to: .init(x: rect.maxX * 0.363, y: rect.maxY))
            $0.addLine(to: .init(x: rect.maxX, y: rect.maxY * 0.173))
            $0.addLine(to: .init(x: rect.maxX * 0.925, y: rect.maxY * 0.073))
            $0.addLine(to: .init(x: rect.maxX * 0.363, y: rect.maxY * 0.805))
        }
    }
}

struct CheckmarkShape_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkShape()
            .frame(width: 120, height: 104)
            .foregroundColor(.marginalen(color: .greenyBlue))
    }
}
