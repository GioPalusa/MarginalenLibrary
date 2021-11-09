//
//  AnalyticsManager+Product.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-18.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

extension AnalyticsManager {
    enum Product: Codable {
        case sparande
        case lonekonto
        case fastrantekonto
        case hograntekonto
        case swish
        case meddelande
        case betalaOverfor
        case push
        case onboarding
        case productname(name: String?)
        case mflex
        case autogiro
        case eInvoice
        case unknown

        var name: String {
            switch self {
            case .sparande: return "Sparande"
            case .lonekonto: return "Lönekonto"
            case .fastrantekonto: return "Fasträntekonto"
            case .hograntekonto: return "Högräntekonto"
            case .swish: return "Swish"
            case .meddelande: return "Meddelande"
            case .betalaOverfor: return "Betala & överför"
            case .onboarding: return "onboarding"
            case .productname(let name): return "\(name ?? "unknown")"
            case .push: return "Push"
            case .mflex: return "MarginalenFlex"
            case .autogiro: return "Autogiro"
            case .eInvoice: return "E-faktura"
            case .unknown: return "unknown"
            }
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let name = try container.decode(String.self)

            switch name {
            case "sparande": self = .sparande
            case "lönekonto": self = .lonekonto
            case "fasträntekonto": self = .fastrantekonto
            case "högräntekonto": self = .hograntekonto
            case "swish": self = .swish
            case "meddelande": self = .meddelande
            case "Betala och överför": self = .betalaOverfor
            case "onboarding": self = .onboarding
            case "MarginalenFlex": self = .mflex
            case "E-faktur": self = .eInvoice
            case "unknown": self = .unknown
            default: self = .productname(name: name)
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .sparande: try container.encode(0)
            case .lonekonto: try container.encode(1)
            case .fastrantekonto: try container.encode(2)
            case .hograntekonto: try container.encode(3)
            case .swish: try container.encode(4)
            case .meddelande: try container.encode(5)
            case .betalaOverfor: try container.encode(6)
            case .onboarding: try container.encode(7)
            case .productname(let name): try container.encode(name)
            case .push: try container.encode(9)
            case .unknown: try container.encode(10)
            case .mflex: try container.encode(11)
            case .autogiro: try container.encode(12)
            case .eInvoice: try container.encode(13)
            }
        }
    }
}
