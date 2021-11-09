//
//  ValidationPublishers.swift
//  Marginalen
//
//  Created by michaelst on 2021-03-31.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Combine
import Foundation

typealias ValidationErrorClosure = () -> String

typealias ValidationPublisher = AnyPublisher<Validation, Never>

// MARK: - ValidationPublishers

enum ValidationPublishers {
    static func notExceedingMaxLimit(for publisher: Published<Double>.Publisher,
                                     maxLimit: Double,
                                     errorMessage: @autoclosure @escaping ValidationErrorClosure) -> ValidationPublisher {
        publisher.map {
            guard $0 <= maxLimit else {
                return .failure(message: errorMessage())
            }
            return .success
        }
        .dropFirst()
        .eraseToAnyPublisher()
    }

    static func notBelowMinLimit(for publisher: Published<Double>.Publisher,
                                 minLimit: Double,
                                 errorMessage: @autoclosure @escaping ValidationErrorClosure) -> ValidationPublisher {
        publisher.map {
            guard $0 >= minLimit else {
                return .failure(message: errorMessage())
            }
            return .success
        }
        .dropFirst()
        .eraseToAnyPublisher()
    }

    // Validates whether a string property is non-empty.
    static func nonEmptyValidation(for publisher: Published<String>.Publisher,
                                   errorMessage: @autoclosure @escaping ValidationErrorClosure) -> ValidationPublisher {
        return publisher.map { value in
            guard !value.isEmpty else {
                return .failure(message: errorMessage())
            }
            return .success
        }
        .dropFirst()
        .eraseToAnyPublisher()
    }

    static func minimumCharacters(minimum: Int,
                                  for publisher: Published<String>.Publisher,
                                  errorMessage: @autoclosure @escaping ValidationErrorClosure) -> ValidationPublisher {
        return publisher.map {
            guard $0.count >= minimum else {
                return .failure(message: errorMessage())
            }
            return .success
        }
        .dropFirst()
        .eraseToAnyPublisher()
    }

    static func regexValidator(for publisher: Published<String>.Publisher,
                               type: ValidatorType, errorMessage: @autoclosure @escaping ValidationErrorClosure) -> ValidationPublisher {
        return publisher.map { value in
            do {
                _ = try VaildatorFactory.validatorFor(type: type).validated(value, with: nil)
            } catch {
                return .failure(message: errorMessage())
            }
            return .success
        }
        .dropFirst()
        .eraseToAnyPublisher()
    }
}
