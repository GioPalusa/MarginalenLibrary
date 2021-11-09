//
//  View+extensions.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2021-03-15.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI
import Combine

extension ViewModifier {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    var isSmallDevice: Bool { UIDevice.current.isSmall }
    var deviceRatio: CGFloat { isSmallDevice ? 0.7 : 1 }

    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: EmptyView()
        case false: self
        }
    }

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    func marginalenShadow() -> some View {
        modifier(MarginalenShadow())
    }

    func bottomShadow() -> some View {
        modifier(MarginalenBottomShadow())
    }

    func buttonShadow() -> some View {
        modifier(ButtonShadow())
    }

    func dimmed() -> some View {
        modifier(DimmedOverlay())
    }

    func validation(_ validationPublisher: ValidationPublisher) -> some View {
        modifier(ValidationModifier(validationPublisher: validationPublisher))
    }

    func onViewDidLoad(_ perform: @escaping () -> Void) -> some View {
        modifier(ViewDidLoadModifier(perform: perform))
    }

    func presentInformationView(status: InformationView.Status,
                                title: String?,
                                message: String,
                                primaryButton: PrimaryButton,
                                secondaryButton: SecondaryButton? = nil,
                                presentModal: Binding<Bool>) -> some View {
        modifier(
            InformationView(status: status,
                           title: title,
                           message: message,
                           primaryButton: primaryButton,
                           secondaryButton: secondaryButton,
                           presentModal: presentModal)
        )
    }

    func onSubmit(_ action: @escaping (() -> Void)) -> some View {
        environment(\.onSubmitAction, action)
    }
}
