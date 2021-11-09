//
//  Chevron.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-10-12.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct Chevron: Shape {
    func path(in rect: CGRect) -> Path {
        Path {
            $0.move(to: .init(x: rect.minX, y: rect.minY))
            $0.addLine(to: .init(x: rect.maxX, y: rect.maxY/2))
            $0.addLine(to: .init(x: rect.minX, y: rect.maxY))
        }
    }
}

struct Chevron_Previews: PreviewProvider {
    static var previews: some View {
        Chevron()
            .stroke(style: .init(lineWidth: 2,
                                 lineCap: .square,
                                 lineJoin: .miter,
                                 miterLimit: 1,
                                 dash: [],
                                 dashPhase: 0))
            .frame(width: 50, height: 100)
            .foregroundColor(.marginalen(color: .greenyBlue))
    }
}
