//
//  LinearProgressView.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-07-08.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct LinearProgressView: View {
    @Binding var progress: Double
    var height: CGFloat = 12

    var backgroundColor: Color = .marginalen(color: .paleAqua)
    var progressColor: Color = .marginalen(color: .greenyBlue)

    var body: some View {
        ProgressView(value: $progress.wrappedValue, total: 100)
            .progressViewStyle(
                LinearProgressViewStyle(
                    backgroundColor: backgroundColor,
                    progressColor: progressColor,
                    height: height
                )
            )
    }
}

private struct LinearProgressViewStyle: ProgressViewStyle {
    let backgroundColor: Color
    let progressColor: Color
    let height: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        return ZStack {
            ProgressLinearShape()
                .trim(from: 0, to: 100)
                .stroke(backgroundColor, lineWidth: height)
            ProgressLinearShape()
                .trim(from: 0, to: CGFloat(fractionCompleted))
                .stroke(progressColor, style: StrokeStyle(lineWidth: height, lineCap: .round))
        }
        .frame(height: height)
    }
}

private struct ProgressLinearShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: rect.minX, y: rect.maxY / 2))
        path.addLine(to: .init(x: rect.maxX, y: rect.maxY / 2))
        return path
    }
}

struct LinearProgressView_Previews: PreviewProvider {
    static var previews: some View {
        LinearProgressView(progress: .constant(50))
    }
}
