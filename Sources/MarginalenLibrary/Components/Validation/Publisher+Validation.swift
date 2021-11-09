//
//  Publisher+Validation.swift
//  Marginalen
//
//  Created by michaelst on 2021-03-31.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation
import Combine

extension Published.Publisher where Value == String {

    func nonEmptyValidator(_ errorMessage: @autoclosure @escaping ValidationErrorClosure) -> ValidationPublisher {
        return ValidationPublishers.nonEmptyValidation(for: self, errorMessage: errorMessage())
    }

    func minimumCharactersValidator(minimum: Int, errorMessage: @autoclosure @escaping ValidationErrorClosure) -> ValidationPublisher {
        return ValidationPublishers.minimumCharacters(minimum: minimum, for: self, errorMessage: errorMessage())
    }

    func regexValidator(type: ValidatorType, errorMessage: @autoclosure @escaping ValidationErrorClosure) -> ValidationPublisher {
        return ValidationPublishers.regexValidator(for: self, type: type, errorMessage: errorMessage())
    }

}

extension Published.Publisher where Value == Double {
    func notExceeding(maxLimit: Double, _ errorMessage: @autoclosure @escaping ValidationErrorClosure) -> ValidationPublisher {
        ValidationPublishers.notExceedingMaxLimit(for: self,
                                                  maxLimit: maxLimit,
                                                  errorMessage: errorMessage())
    }

    func notBelow(minLimit: Double, _ errorMessage: @autoclosure @escaping ValidationErrorClosure) -> ValidationPublisher {
        ValidationPublishers.notBelowMinLimit(for: self,
                                              minLimit: minLimit,
                                              errorMessage: errorMessage())
    }
}
