//
//  AnyTransition+extensions.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-09-02.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

extension AnyTransition {
    static var slideInFadeOut: AnyTransition {
        let insertion: AnyTransition = .slide
        let removal: AnyTransition = .opacity
        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }
}
