//
//  Validation.swift
//  Marginalen
//
//  Created by michaelst on 2021-03-31.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

enum Validation {
    case success
    case failure(message: String)

    var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
}
