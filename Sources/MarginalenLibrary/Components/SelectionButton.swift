//
//  SelectionButton.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-08-19.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

protocol SelectionButtonMetaData: Equatable {
    var id: UUID { get }
    var text: String { get }
}

// Default data for just a simple "Yes" and "No" data.
enum DefaultSelectionButtonData: SelectionButtonMetaData, CaseIterable {
    case yes, nope

    var id: UUID { UUID() }

    var text: String {
        switch self {
        case .yes: return "yes".localized()
        case .nope: return "no".localized()
        }
    }
}

struct SelectionButton<Data: SelectionButtonMetaData>: View {
    let buttonMetaData: Data
    @Binding var selectedButton: Data?
    private let height: CGFloat = 50
    var width: CGFloat? = 110
    var action: () -> Void

    var body: some View {
        VStack(spacing: 50) {
            Button(action: {
                selectedButton = buttonMetaData
                action()
            }, label: {
                Text(buttonMetaData.text)
                    .font(font: .boldButtonText)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .multilineTextAlignment(.center)
                    .foregroundColor(selectedButton == buttonMetaData ? .white : .marginalen(color: .primaryRed))
                    .frame(idealWidth: width,
                           maxWidth: .infinity,
                           minHeight: height,
                           maxHeight: height,
                           alignment: .center)
            })
            .background(selectedButton == buttonMetaData ? .marginalen(color: .primaryRed) : Color.secondarySystemGroupedBackground)
            .border(Color.marginalen(color: .primaryRed), width: 2)
            .cornerRadius(4)
        }
    }
}

struct SelectionButton_Previews: PreviewProvider {
    enum PreviewData: SelectionButtonMetaData {
        case yes, nope, somethingElse

        var id: UUID { UUID() }
        var text: String {
            switch self {
            case .yes: return "Hyresrätt"
            case .nope: return "Bostadsrätt"
            case .somethingElse: return "Villa/Radhus"
            }
        }
    }
    static var previews: some View {
        HStack {
            SelectionButton(buttonMetaData: PreviewData.yes, selectedButton: .constant(nil)) {}
            SelectionButton(buttonMetaData: PreviewData.nope, selectedButton: .constant(nil)) {}
            SelectionButton(buttonMetaData: PreviewData.somethingElse, selectedButton: .constant(nil), width: 120, action: {})
        }.padding(.horizontal, 16)
    }
}
