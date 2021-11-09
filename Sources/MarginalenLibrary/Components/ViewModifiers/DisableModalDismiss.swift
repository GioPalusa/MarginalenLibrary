//
//  DisableModalDismiss.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-09-09.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct DisableModalDismiss: ViewModifier {
    let disabled: Bool

    func body(content: Content) -> some View {
        disableModalDismiss()
        return AnyView(content)
    }

    private func disableModalDismiss() {
        guard let visibleViewController = UIApplication.shared.visibleViewController() else { return }
        visibleViewController.isModalInPresentation = disabled
    }
}
