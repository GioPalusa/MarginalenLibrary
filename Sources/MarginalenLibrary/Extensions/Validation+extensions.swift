//
//  Validation+extensions.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2019-05-20.
//  Copyright © 2019 Marginalen Bank. All rights reserved.
//

import UIKit

protocol ValidatorConvertible {
    func validated(_ value: String?, with sender: Any?) throws -> String
}

struct ValidationError: Error {
    var message: String

    init(_ message: String) {
        self.message = message
    }

    init(_ errorType: ErrorFieldName) {
        message = RequiredFieldValidator(errorType).fieldName
    }

    enum ErrorFieldName {
        case companyName
        case compulsoryField
        case city
        case dateOfResidence
        case employmentStatus
        case firstName
        case genericValue
        case lastName
        case maritalStatus
        case message
        case monthlyIncome
        case name
        case personNumber
        case street
        case subject
        case paymentRecipient
        case paymentAccount
        case purposeForSwishLimit
        case purposeForLoan
        case typeOfResidence
        case payerNumber
        case swishAccountNumber
    }
}

enum ValidatorType {
    case email
    case date
    case requiredField(fieldNameForError: ValidationError.ErrorFieldName)
    case numbers
    case personnr
    case phoneNumber
    case income(minimumIncome: Int)
    case maxAmount(creditAccount: MarginalenCard)
    case paymentAmount
    case paymentDate
    case ocr
    case recipientValidation
    case swishVerificationCode
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String?, with sender: Any?) throws -> String {
        let errorMessage = NSLocalizedString("ERROR_Valid_Email", comment: "Error message when email is not valid")
        guard let value = value else { throw ValidationError(errorMessage) }
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}$",
                                       options: .caseInsensitive).firstMatch(in: value,
                                                                             options: [],
                                                                             range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError(errorMessage)
            }
        } catch {
            throw ValidationError(errorMessage)
        }
        return value
    }
}

struct DateValidator: ValidatorConvertible {
    func validated(_ value: String?, with sender: Any?) throws -> String {
        let errorMessage = NSLocalizedString("ERROR_missing_Date", comment: "Error message when date is empty")
        guard let value = value, value != "" else { throw ValidationError(errorMessage) }
        return value
    }
}

struct PersonNumberValidator: ValidatorConvertible {
    let viewModel = SwedishSSNViewModel()

    func validated(_ value: String?, with sender: Any?) throws -> String {
        let errorMessage = NSLocalizedString("ERROR_missing_SSN", comment: "Error message when personnumber is empty")
        guard let value = value else { throw ValidationError(errorMessage) }
        if viewModel.isValidPersonalNumber(ssn: value) {
            return value
        }
        throw ValidationError(NSLocalizedString("ERROR_invalid_SSN", comment: "Error message when personnumber is invalid"))
    }
}

struct NumberValidator: ValidatorConvertible {
    func validated(_ value: String?, with sender: Any?) throws -> String {
        let errorMessage = NSLocalizedString("ERROR_NaN", comment: "Error message when number is not valid")
        guard let value = value, SwedishCrownsFormatter.standard.number(from: value) != nil else {
            throw ValidationError(errorMessage)
        }
        return String(value)
    }
}

struct IncomeValidator: ValidatorConvertible {
    let errorMessage = NSLocalizedString("ERROR_NaN", comment: "Error message when number is not valid")
    private let minimumValue: Int

    init(_ limitValue: Int) {
        minimumValue = limitValue
    }

    func validated(_ value: String?, with sender: Any?) throws -> String {
        guard let value = value, SwedishCrownsFormatter.standard.number(from: value) != nil else {
            throw ValidationError(errorMessage)
        }
        guard let valueInt = Int(value), valueInt >= minimumValue else {
            let incomeTooLow = NSLocalizedString("ERROR_Income_too_low", comment: "Error message when income is too low")
            throw ValidationError(incomeTooLow)
        }
        return String(value)
    }
}

struct CardMaxAmountValidator: ValidatorConvertible {
    let errorMessage = NSLocalizedString("ERROR_NaN", comment: "Error message when number is not valid")
    private let card: MarginalenCard

    init(_ card: MarginalenCard) {
        self.card = card
    }

    func validated(_ value: String?, with sender: Any?) throws -> String {
        guard let value = value, let valueNumber = SwedishCrownsFormatter.standard.number(from: value) else {
            throw ValidationError(errorMessage)
        }
        // Max limit for credit card usage is 50 000 SEK
        guard Double(truncating: valueNumber) <= 50000 else {
            let maxedOutSum = "Maxbeloppet för kreditkortsbetalningar är 50 000 SEK".localized()
            throw ValidationError(maxedOutSum)
        }
        guard Double(truncating: valueNumber) <= card.cardAccount?.creditLeftToUse ?? 0 else {
            let notEnoughCredit = "Du kan inte använda mer än ditt kreditutrymme".localized()
            throw ValidationError(notEnoughCredit)
        }
        return String(value)
    }
}

struct PhoneNumberValidator: ValidatorConvertible {
    func validated(_ value: String?, with sender: Any?) throws -> String {
        let errorMessage = NSLocalizedString("ERROR_Valid_PhoneNr",
                                             comment: "Error message when phone number is not valid")
        guard let value = value else { throw ValidationError(errorMessage) }
        let phoneRegex = "^\\s*(?:\\+?(\\d{1,3}))?[-. (]*(\\d{3})[-. )]*(\\d{3})[-. ]*(\\d{4})(?: *x(\\d+))?\\s*$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let result = phoneTest.evaluate(with: value)

        if result {
            return String(value)
        }
        throw ValidationError(errorMessage)
    }
}

struct PaymentAmountValidator: ValidatorConvertible {
    func validated(_ value: String?, with sender: Any?) throws -> String {
        guard let value = value, let number = SwedishCrownsFormatter.standard.number(from: value),
            number.doubleValue >= 0.01 else {
            let errorMessage = NSLocalizedString("ERROR_invalid_payment_amount", comment: "Error message when amount is not valid")
            throw ValidationError(errorMessage)
        }

        guard number.doubleValue <= 9_999_999_999_999.99 else {
            let errorMessage = NSLocalizedString("ERROR_invalid_payment_maximum_amount", comment: "Error message when amounts are above the maximum limit")
            throw ValidationError(errorMessage)
        }
        return value
    }
}

struct PaymentDateValidator: ValidatorConvertible {
    func validated(_ value: String?, with sender: Any?) throws -> String {
        let errorMessage = NSLocalizedString("ERROR_field_payment_date", comment: "Error message when date is empty")
        let today = Date.swedishDate
        guard let value = value, let date = DateFormatter.dayMonthYearFormatter.date(from: value), date > today.dayBefore else { throw ValidationError(errorMessage) }
        return value
    }
}

struct OCRValidator: ValidatorConvertible {
    func validated(_ value: String?, with sender: Any?) throws -> String {
        let errorMessage = NSLocalizedString("ERROR_field_payment_ocr", comment: "Field name for payment OCR")
        guard let value = value,
            !value.isEmpty,
            let ocrType = sender as? GiroValidation.OCR else {
                throw ValidationError(errorMessage)
        }

        switch ocrType {
        case .BG_NOT_CONNECTED, .PG_NOT_CONNECTED: throw ValidationError(errorMessage)
        case .BG_CONNECTED_SOFT: return value
        case .BG_CONNECTED_HARD, .PG_CONNECTED:
            guard value.checkValid10Modulus() else {
                throw ValidationError(errorMessage)
            }
        case .BG_CONNECTED_HARD_UNSPECIFIC_LENGT:
            guard ValidationRepository.shared.isValidUnspecificLength(input: value) else {
                throw ValidationError(errorMessage)
            }
        case .BG_CONNECTED_HARD_SPECIFIC_LENGTH(let lengths):
            guard ValidationRepository.shared.isValidSpecificLength(input: value, length: lengths.length1, length2: lengths.length2) else {
                throw ValidationError(errorMessage)
            }
        case .INTERNAL: return value
        }
        return value
    }
}

struct RecipientValidator: ValidatorConvertible {
    func validated(_ value: String?, with sender: Any?) throws -> String {
        let errorMessage = NSLocalizedString("ERROR_field_payment_sameAccount", comment: "Field error when the user has chosen the same recipient as sender.")
        guard let (recipientNumbersOptional, accountNumberOptional) = sender as? (String?, String?),
            let value = value  else {
            throw ValidationError(errorMessage)
        }

        guard let recipientNumbers = recipientNumbersOptional,
            let accountNumber = accountNumberOptional else {
                return value
        }

        guard recipientNumbers != accountNumber else {
            throw ValidationError(errorMessage)
        }

        return value
    }
}

struct SwishVerificationCodeValidator: ValidatorConvertible {
    func validated(_ value: String?, with sender: Any?) throws -> String {
        let errorMessage = NSLocalizedString("ERROR_valid_swish_verification_code", comment: "Error message when swish verification code is not valid")
        guard let value = value else { throw ValidationError(errorMessage) }
        let verificationCodeRegex = "^[0-9]{6}$"
        let verificationCodeTest = NSPredicate(format: "SELF MATCHES %@", verificationCodeRegex)
        let result = verificationCodeTest.evaluate(with: value)

        if result {
            return String(value)
        }
        throw ValidationError(errorMessage)
    }
}

struct RequiredFieldValidator: ValidatorConvertible {
    let errorMessage = NSLocalizedString("ERROR_required_field", comment: "Should be used as: Enter XXXX")
    let fieldName: String

    init(_ field: ValidationError.ErrorFieldName) {
        switch field {
        case .compulsoryField: fieldName = NSLocalizedString("error_required_field", comment: "Message for when no option was selected")
        case .city: fieldName = NSLocalizedString("ERROR_field_city", comment: "Field name for city")
        case .dateOfResidence: fieldName = NSLocalizedString("ERROR_field_dateOfResidence", comment: "Field name for date of residence")
        case .employmentStatus: fieldName = NSLocalizedString("ERROR_field_employmentStatus", comment: "Field name for employment status")
        case .genericValue: fieldName = NSLocalizedString("ERROR_field_generic_value", comment: "Generic field name for 'enter value'")
        case .maritalStatus: fieldName = NSLocalizedString("ERROR_field_maritalStatus", comment: "Field name for marital status")
        case .monthlyIncome: fieldName = NSLocalizedString("ERROR_field_monthlyIncome", comment: "Field name for monthly Income")
        case .name: fieldName = NSLocalizedString("ERROR_field_name", comment: "Field name for name")
        case .personNumber: fieldName = NSLocalizedString("ERROR_field_personNumber", comment: "Field name for person number")
        case .typeOfResidence: fieldName = NSLocalizedString("ERROR_field_typeOfResidence", comment: "Field name for type of residence")
        case .companyName: fieldName = NSLocalizedString("ERROR_field_companyName", comment: "Field name for company name")
        case .subject: fieldName = NSLocalizedString("ERROR_field_subject", comment: "Field name for subject")
        case .message: fieldName = NSLocalizedString("ERROR_field_message", comment: "Field name for message")
        case .paymentRecipient: fieldName = NSLocalizedString("ERROR_field_payment_recipient", comment: "Field name for payment recipient")
        case .paymentAccount: fieldName = NSLocalizedString("ERROR_field_payment_acount", comment: "Field name for payment account")
        case .purposeForSwishLimit: fieldName = NSLocalizedString("ERROR_swish_purpose", comment: "Field name for Swish purpose")
        case .purposeForLoan: fieldName = NSLocalizedString("ERROR_loan_purpose", comment: "Field name for Loan purpose")
        case .firstName: fieldName = NSLocalizedString("ERROR_field_first_name", comment: "Field name for first name")
        case .lastName: fieldName = NSLocalizedString("ERROR_field_last_name", comment: "Field name for last name")
        case .street: fieldName = NSLocalizedString("ERROR_street_name", comment: "Field name for street address")
        case .payerNumber: fieldName = NSLocalizedString("ERROR_payer_number", comment: "Field name for payer number")
        case .swishAccountNumber: fieldName = NSLocalizedString("ERROR_swish_account_number", comment: "Field name for Swish account number")
        }
    }

    func validated(_ value: String?, with sender: Any?) throws -> String {
        guard let value = value, !value.isEmpty else {
            throw ValidationError(errorMessage + " " + fieldName)
        }
        return value
    }
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .date: return DateValidator()
        case .personnr: return PersonNumberValidator()
        case .numbers: return NumberValidator()
        case .phoneNumber: return PhoneNumberValidator()
        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        case .income(let minimumIncome): return IncomeValidator(minimumIncome)
        case .maxAmount(let amount): return CardMaxAmountValidator(amount)
        case .paymentAmount: return PaymentAmountValidator()
        case .paymentDate: return PaymentDateValidator()
        case .ocr: return OCRValidator()
        case .recipientValidation: return RecipientValidator()
        case .swishVerificationCode: return SwishVerificationCodeValidator()
        }
    }
}

extension UITextField {
    @discardableResult
    func validateField(validationType: ValidatorType, with sender: Any? = nil) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(text, with: sender)
    }
}

extension UITextView {
    @discardableResult
    func validateField(validationType: ValidatorType, with sender: Any? = nil) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(text, with: sender)
    }
}

extension UILabel {
    @discardableResult
    func validateField(validationType: ValidatorType, with sender: Any? = nil) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(text, with: sender)
    }
}
