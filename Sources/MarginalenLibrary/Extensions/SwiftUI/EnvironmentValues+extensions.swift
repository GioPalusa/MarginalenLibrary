//
//  EnvironmentValues+extensions.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-09-09.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

extension EnvironmentValues {
    var modalMode: Binding<Bool> {
        get { self[ModalModeKey.self] }
        set { self[ModalModeKey.self] = newValue }
    }

    var onSubmitAction: () -> Void {
        get { self[TriggerSubmitKey.self] }
        set {
            let oldValue = self[TriggerSubmitKey.self]
            self[TriggerSubmitKey.self] = {
                oldValue()
                newValue()
            }
        }
    }
}

// For dismissing modals in a navigation stack
struct ModalModeKey: EnvironmentKey {
    static let defaultValue = Binding<Bool>.constant(false)
}

// To trigger a submit action, for instance after completing an application, you might want to fetch data in the parent view.
struct TriggerSubmitKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}
