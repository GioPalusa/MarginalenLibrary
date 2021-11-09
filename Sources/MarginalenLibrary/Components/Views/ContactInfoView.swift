//
//  ContactInfoView.swift
//  Marginalen
//
//  Created by michaelst on 2021-06-04.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

// MARK: - ContactInfoView

struct ContactInfoView: View {
    @ObservedObject var viewModel: ContactInfoViewModel

    var body: some View {
        AsyncContentView(source: viewModel,
                         loadingView: ContactInfoLoadingView(),
                         errorView: ContactInfoLoadingErrorView(),
                         content: ContactInfoContentView.init)
    }
}

// MARK: - ContactInfoContentView

struct ContactInfoContentView: View {
    @ObservedObject var viewModel: ContactInfoViewModel

    var nameView: some View {
        HStack {
            Text(viewModel.name)
                .font(font: .regularTitle)
            Spacer()
            Button(action: { withAnimation {
                viewModel.logButtonTapToAnalytics(buttonTitle: viewModel.mode.buttonText)
                if viewModel.mode == .regular {
                    viewModel.getContactInfo()
                }
                viewModel.toggleEditMode()
            }}, label: {
                Text(viewModel.mode.buttonText)
                    .foregroundColor(Color(UIColor.MarginalenColors.primaryRed.color))
                    .font(font: .boldButtonText)
            })
            .hidden(viewModel.showToggleModeButton == false)
        }
    }

    var contactInformationView: some View {
        VStack {
            PhoneNumberView(phoneNumber: $viewModel.phoneNumber)
                .padding(.bottom, 16)
            EmailAddressView(emailAddress: $viewModel.emailAddress)
            AdressInfoView(adressLine1: viewModel.adressLine1,
                           adressLine2: viewModel.adressLine2)
                .hidden(!viewModel.isAddressVisible)
                .padding(.top, 16)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 32)
    }

    var editView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider()
            SimpleCellView(label: viewModel.phoneLabel,
                           text: $viewModel.editPhoneNumber,
                           isEditable: true,
                           keyboardType: UIKeyboardType.numberPad)
                .validation(viewModel.allPhoneValidation)
            SimpleCellView(label: viewModel.emailLabel,
                           text: $viewModel.editEmailAddress,
                           isEditable: true,
                           keyboardType: UIKeyboardType.emailAddress,
                           isDividerHidden: !viewModel.isAddressVisible)
                .validation(viewModel.allEmailValidation)
            SimpleCellView(label: viewModel.addressLabel,
                           text: Binding<String>.constant(viewModel.nonEditableAddressText),
                           isDividerHidden: true)
                .hidden(!viewModel.isAddressVisible)
        }
    }

    var body: some View {
        VStack {
            nameView
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            if viewModel.mode == .regular {
                contactInformationView
            } else {
                editView
            }
        }
        .animation(viewModel.isAnimationsEnabled ? .default : nil)
    }
}

// MARK: - AdressInfoView

struct AdressInfoView: View {
    var adressLine1: String = ""
    var adressLine2: String = ""

    var body: some View {
        HStack {
            Icon(.location)
                .frame(width: 18)
            VStack {
                HStack {
                    Text(adressLine1)
                    Spacer()
                }
                HStack {
                    Text(adressLine2)
                    Spacer()
                }
            }
            .padding(.leading, 16)
            Spacer()
        }
        .font(font: .body)
        .foregroundColor(Color(UIColor.MarginalenColors.bluishGrey.color))
    }
}

// MARK: - PhoneNumberView

struct PhoneNumberView: View {
    @Binding var phoneNumber: String

    var body: some View {
        HStack {
            Icon(.phone)
                .frame(width: 18)
            Text(phoneNumber)
                .padding(.leading, 16)
            Spacer()
        }
        .font(font: .body)
        .foregroundColor(Color(UIColor.MarginalenColors.bluishGrey.color))
    }
}

// MARK: - EmailAddressView

struct EmailAddressView: View {
    @Binding var emailAddress: String

    var body: some View {
        HStack {
            Icon(.email)
                .frame(width: 18)
            Text(emailAddress)
                .padding(.leading, 16)
            Spacer()
        }
        .font(font: .body)
        .foregroundColor(Color(UIColor.MarginalenColors.bluishGrey.color))
    }
}

// MARK: - ContactInfoLoadingView

struct ContactInfoLoadingView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ActivityIndicatorComponent(isAnimating: Binding<Bool>.constant(true), color: UIColor.MarginalenColors.primaryRed.color, style: .large)
                Spacer()
            }
        }
        .padding(.bottom, 32)
    }
}

// MARK: - ContactInfoLoadingErrorView

struct ContactInfoLoadingErrorView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("ERROR_title_something_went_wrong")
                    .font(font: .regularTitle)
                Spacer()
            }
        }
        .padding(.bottom, 32)
    }
}

// MARK: - ContactInfoView_Previews

struct ContactInfoView_Previews: PreviewProvider {
    static var viewModel: ContactInfoViewModel = {
        let viewModel = ContactInfoViewModel()
        viewModel.name = "Nisse Nilsson"
        viewModel.phoneNumber = "072-1231234"
        viewModel.emailAddress = "nisse@swipnet.se"
        viewModel.adressLine1 = "Storgatan 8"
        viewModel.adressLine2 = "123 45 Stockholm"
        viewModel.toggleEditMode()
        return viewModel
    }()

    static var previews: some View {
        GroupedPreview(view: ContactInfoContentView(viewModel: viewModel))
    }
}
