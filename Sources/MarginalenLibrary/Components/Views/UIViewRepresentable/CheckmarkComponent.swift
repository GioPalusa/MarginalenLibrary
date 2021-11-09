//
//  CheckmarkComponent.swift
//  Marginalen
//
//  Created by michaelst on 2021-10-25.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct CheckmarkComponent: UIViewRepresentable {
    var frame: CGRect

    func makeUIView(context: Context) -> Checkmark {
        let checkmark = Checkmark(frame: frame)
        checkmark.setCheckboxType(type: .animatedView)
        checkmark.setUseCircle(bool: false)
        checkmark.setColor(color: UIColor.white.cgColor)
        checkmark.setLineWidth(width: 3)
        return checkmark
    }

    func updateUIView(_ checkmark: Checkmark, context: Context) {
        checkmark.start()
    }
}
