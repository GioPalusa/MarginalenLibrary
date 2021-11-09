//
//  Encodable+extensions.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2020-11-16.
//  Copyright © 2020 Marginalen Bank. All rights reserved.
//

import Foundation

extension Encodable {
    /// returns a `[String:Any]` dictionary from a encodable object. Throws
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }

    /// returns a `[String:Any]` dictionary from a encodable object
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
