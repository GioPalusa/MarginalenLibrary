//
//  Binding+extensions.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2021-03-18.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

extension Binding {
    func didSet(_ execute: @escaping (Value) -> Void) -> Binding {
        return Binding(
            get: {
                return self.wrappedValue
            },
            set: {
                self.wrappedValue = $0
                execute($0)
            }
        )
    }

    func onChange(_ completion: @escaping (Value) -> Void) -> Binding<Value> {
        .init(get: { self.wrappedValue }, set: { self.wrappedValue = $0; completion($0) })
    }

    func onInputFieldTap() { }
}
