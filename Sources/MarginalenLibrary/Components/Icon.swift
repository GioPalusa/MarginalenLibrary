//
//  Icon.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-25.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct Icon: View {
    private let icon: IconGenerator
    private var isResizable: Bool

    init(_ icon: IconGenerator, isResizable: Bool = false) {
        self.icon = icon
        self.isResizable = isResizable
    }

    var body: some View {
        let image = icon.image
        return isResizable ? image.resizable() : image
    }

    func resizable() -> Icon {
        Icon(icon, isResizable: true)
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        Icon(.rightChevron)
    }
}
