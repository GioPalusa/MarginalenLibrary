//
//  DatePickerFieldView.swift
//  Marginalen
//
//  Created by michaelst on 2021-06-03.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

// MARK: - DatePickerFieldView

struct DatePickerFieldView: View {
    var label: String
    @Binding var selectedDate: Date?
    @State private var isPickerVisible = false
    @State private var delay: Double = 0
    var datePickerRange: Range = .default
    var icon: IconGenerator? = .select

    enum Range {
        case upToToday
        case fromToday
        case `default`
    }

    var labelView: some View {
        HStack {
            Text(label)
                .font(font: .title)
               .foregroundColor(Color(UIColor.MarginalenColors.bluishGrey.color))
                .frame(height: 20)
            Spacer()
        }
    }

    var textView: some View {
        HStack {
            Text(selectedDate?.toShortDate() ?? "")
                .font(font: .largeText)
                .foregroundColor(.label)
                .frame(height: 20).frame(height: 20)
            Spacer()
        }
    }

    var picker: some View {
        let selection = Binding<Date>(
            get: { self.selectedDate ?? Date() },
            set: { self.selectedDate = $0 }
        )

        return Group {
            switch datePickerRange {
            case .default:
                DatePicker("",
                           selection: selection,
                           displayedComponents: .date)
            case .upToToday:
                DatePicker("",
                           selection: selection,
                           in: ...Date(),
                           displayedComponents: .date)
            case .fromToday:
                DatePicker("",
                           selection: selection,
                           in: Date()...,
                           displayedComponents: .date)
            }
        }
        .datePickerStyle(WheelDatePickerStyle())
        .scaleEffect(0.8)
        .labelsHidden()
        .frame(height: 120)
        .clipped()
        .onAppear {
            if selectedDate == nil {
                selectedDate = Date()
            }
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack {
                    VStack(spacing: 0) {
                        labelView
                        textView
                            .padding(.top, 4)
                    }
                    if let icon = icon {
                        Icon(icon)
                            .frame(width: 24, height: 24)
                    }
                }
                .padding(.top, 16)
                .padding(.bottom, 28)
                .padding(.horizontal, 16)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(Animation.easeIn.delay(delay)) {
                    delay = isPickerVisible ? 0 : 0.15
                    isPickerVisible.toggle()
                }
            }
            Divider()
                .frame(height: 1)
            VStack(spacing: 0) {
                if isPickerVisible {
                    picker
                    Divider()
                        .frame(height: 1)
                }
            }
            .contentShape(Rectangle())
            .animation(Animation.easeIn.delay(delay), value: isPickerVisible)
        }
    }
}

// MARK: - DatePickerFieldView_Previews

struct DatePickerFieldView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            InputFieldView(label: "Mottagare",
                           placeholder: "Klicka här för att fylla i information",
                           text: Binding<String>.constant("Text"))
            DatePickerFieldView(label: "Datum",
                                selectedDate: Binding<Date?>.constant(nil))
            InputFieldView(label: "Mottagare",
                           placeholder: "Klicka här för att fylla i information",
                           text: Binding<String>.constant("Text"))
            Spacer()
        }
    }
}
