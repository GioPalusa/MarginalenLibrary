//
//  ContactInfoViewModel.swift
//  Marginalen
//
//  Created by michaelst on 2021-06-07.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Combine
import Foundation

// MARK: - ContactInfoViewModel

class ContactInfoViewModel: LoadableObject {
    // MARK: Internal

    enum Mode {
        case edit
        case regular

        // MARK: Internal

        var buttonText: String {
            switch self {
            case .regular: return NSLocalizedString("edit", comment: "")
            case .edit: return NSLocalizedString("cancel", comment: "")
            }
        }
    }

    init(isAddressVisible: Bool = true) {
        self.isAddressVisible = isAddressVisible
    }

    let phoneLabel = NSLocalizedString("contact_info_phone_label", comment: "Phone label")
    let emailLabel = NSLocalizedString("contact_info_email_label", comment: "Email label")
    let addressLabel = NSLocalizedString("contact_info_address_label", comment: "Address label")
    let nonEditableAddressText: String = NSLocalizedString("contact_info_not_editable_text", comment: "Address not editable text")
    let confirmationSuccessTitle = NSLocalizedString("my_account_update_customer_confirmation_success_title", comment: "Confirmation title")
    let confirmationSuccessText = NSLocalizedString("my_account_update_customer_confirmation_success_text", comment: "Confirmation text")
    let confirmationFailureText = NSLocalizedString("my_account_update_customer_confirmation_failure_text", comment: "Confirmation text")

    @Published private(set) var state: LoadingState<ContactInfoViewModel> = .idle
    @Published var editPhoneNumber: String = ""
    @Published var editEmailAddress: String = ""
    @Published var isUpdating: Bool = false
    @Published var showConfirmationSuccess: Bool = false
    @Published var showConfirmationFailure: Bool = false
    @Published var hasErrors: Bool = false
    @Published var mode: Mode = .regular
    var analyticsCategory: AnalyticsManager.Category = .unknown
    var analyticsProduct: AnalyticsManager.Product = .unknown
    var analyticsPageheadline = String()

    var id: String = ""
    var name: String = ""
    var adressLine1: String = ""
    var adressLine2: String = ""
    var zipCode: String = ""
    var city: String = ""
    var isPhoneValid: Bool = true
    var isEmailValid: Bool = true
    var phoneNumber: String = ""
    var emailAddress: String = ""
    var isAddressVisible: Bool = true
    var showToggleModeButton: Bool = true
    var isAnimationsEnabled: Bool = true
    var customer: CustomerInfo?

    lazy var phoneNonEmptyValidator: ValidationPublisher = {
        $editPhoneNumber.nonEmptyValidator(self.phoneInvalidMessage)
    }()

    lazy var phoneRegexValidator: ValidationPublisher = {
        $editPhoneNumber.regexValidator(type: .phoneNumber, errorMessage: self.phoneInvalidMessage)
    }()

    lazy var allPhoneValidation: ValidationPublisher = {
        Publishers.CombineLatest(
            phoneNonEmptyValidator,
            phoneRegexValidator
        ).map { var1, var2 in
            self.isPhoneValid = [var1, var2].allSatisfy { $0.isSuccess } ? true : false
            return [var1, var2].allSatisfy { $0.isSuccess } ? .success : .failure(message: self.phoneInvalidMessage)
        }.eraseToAnyPublisher()
    }()

    lazy var emailNonEmptyValidator: ValidationPublisher = {
        $editEmailAddress.nonEmptyValidator(self.emailInvalidMessage)
    }()

    lazy var emailRegexValidator: ValidationPublisher = {
        $editEmailAddress.regexValidator(type: .email, errorMessage: self.emailInvalidMessage)
    }()

    lazy var allEmailValidation: ValidationPublisher = {
        Publishers.CombineLatest(
            emailNonEmptyValidator,
            emailRegexValidator
        ).map { var1, var2 in
            self.isEmailValid = [var1, var2].allSatisfy { $0.isSuccess } ? true : false
            return [var1, var2].allSatisfy { $0.isSuccess } ? .success : .failure(message: self.emailInvalidMessage)
        }.eraseToAnyPublisher()
    }()

    var isValid: Bool {
        if mode == .regular { return true }
        return isPhoneValid && isEmailValid
    }

    var isUpdated: Bool {
        return editPhoneNumber != phoneNumber || editEmailAddress != emailAddress
    }

    func toggleEditMode() {
        mode = mode == .regular ? .edit : .regular
    }

    func load() {
        state = .loading
        getContactInfo()
    }

    func getContactInfo() {
        hasErrors = false
        cancellable = model.getCustomerInfo().sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                self.hasErrors = true
                self.state = .failed(error)
            case .finished: ()
            }
        }, receiveValue: { customer in
            self.customer = customer
            self.id = customer.id
            self.name = "\(customer.firstName) \(customer.lastName)"
            self.editPhoneNumber = customer.contactInformation.mobileNumber ?? ""
            self.phoneNumber = customer.contactInformation.mobileNumber ?? ""
            self.editEmailAddress = customer.contactInformation.email ?? ""
            self.emailAddress = customer.contactInformation.email ?? ""
            self.adressLine1 = customer.addresses.first?.address1 ?? ""
            self.adressLine2 = "\(customer.addresses.first?.postalCode ?? "") \(customer.addresses.first?.city ?? "")"
            self.zipCode = customer.addresses.first?.postalCode ?? ""
            self.city = customer.addresses.first?.city ?? ""
            self.state = .loaded(self)
            if self.phoneNumber.isEmpty || self.emailAddress.isEmpty {
                self.isPhoneValid = !self.phoneNumber.isEmpty
                self.isEmailValid = !self.emailAddress.isEmpty
                self.toggleEditMode()
                self.showToggleModeButton = false
            }
        })
    }

    func updatePersonalInfo(finished: @escaping () -> Void) {
        if mode == .regular {
            finished()
            return
        }
        isUpdating.toggle()
        if !isUpdated {
            isUpdating.toggle()
            toggleEditMode()
            finished()
            return
        }
        cancellable = model.updateCustomerInfo(id: id,
                                               email: editEmailAddress,
                                               mobileNumber: editPhoneNumber).sink(receiveCompletion: { completion in
            switch completion {
            case .failure: ()
                self.showConfirmationFailure = true
                self.isUpdating.toggle()
                self.getContactInfo()
                finished()
            case .finished: ()
                self.showConfirmationSuccess = true
                self.isUpdating.toggle()
                finished()
            }
        }, receiveValue: { contactInfo in
            self.phoneNumber = contactInfo.mobileNumber
            self.emailAddress = contactInfo.email
        })
    }

    func logButtonTapToAnalytics(buttonTitle: String, next: AnalyticsManager.Next? = nil) {
        AnalyticsManager.log(name: AnalyticsManager.Name.button,
                             action: AnalyticsManager.Action.click,
                             label: buttonTitle,
                             category: analyticsCategory,
                             product: analyticsProduct,
                             iconName: nil,
                             color: nil,
                             position: nil,
                             type: AnalyticsManager.LogType.text,
                             linkType: AnalyticsManager.Linktype.internalLink,
                             header: nil,
                             pageHeadline: analyticsPageheadline,
                             next: next)
    }

    // MARK: Private

    private let model = CustomerModel()
    private var cancellable: AnyCancellable?
    private let phoneInvalidMessage = NSLocalizedString("ERROR_Valid_PhoneNr", comment: "Error message when phone number is not valid")
    private let emailInvalidMessage = NSLocalizedString("ERROR_Valid_Email", comment: "Error message when email is not valid")
}
