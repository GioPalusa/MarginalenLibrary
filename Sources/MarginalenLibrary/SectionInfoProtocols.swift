//
//  SectionInfo.swift
//  Marginalen
//
//  Created by michaelst on 2021-03-16.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

protocol CellInfo {
    var id: UUID { get }
    var title: String { get }
    var body: String? { get }
    var isExpandable: Bool { get }
    var url: String? { get }
}

extension CellInfo {
    var body: String? { return nil }
    var isExpandable: Bool { return false }
    var url: String? { return nil }
}

protocol SectionInfo {
    var info: [CellInfo] { get }
    var title: String { get set }
}
