//
//  MonthYearPickerFieldView.swift
//  Marginalen
//
//  Created by michaelst on 2021-08-09.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

// MARK: - MonthYearPickerFieldView

struct MonthYearPickerFieldView: View {
    // MARK: Internal

    @ObservedObject var viewModel: MonthYearPickerViewModel
    @Binding var selectedValue: String
    var onTap: (() -> Void) = {}
    var onChangedDate: (() -> Void) = {}

    init(viewModel: MonthYearPickerViewModel,
         selectedValue: Binding<String>,
         onTap: @escaping (() -> Void) = {},
         onChangedDate: @escaping (() -> Void) = {}) {
        self.viewModel = viewModel
        self._selectedValue = selectedValue
        self.onTap = onTap
        self.onChangedDate = onChangedDate
    }

    var labelView: some View {
        HStack {
            Text(viewModel.label)
                .font(font: .title)
                .foregroundColor(Color(UIColor.MarginalenColors.bluishGrey.color))
                .frame(height: 20)
            Spacer()
        }
    }

    var textView: some View {
        HStack {
            Text(selectedValue)
                .font(font: .largeText)
                .foregroundColor(.label)
                .frame(height: 20).frame(height: 20)
            Spacer()
        }
    }

    var monthYearPicker: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Picker(selection: $viewModel.monthIndex.onChange(self.monthChanged), label: Text("")) {
                    ForEach(0..<viewModel.monthSymbols.count) { index in
                        Text(viewModel.monthSymbols[index].firstUppercased)
                            .font(font: .largeText)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: geometry.size.width / 2, height: 120).clipped()
                Picker(selection: $viewModel.yearIndex.onChange(self.yearChanged), label: Text("")) {
                    ForEach(0..<viewModel.selectableYears.count) { index in
                        Text(String(viewModel.selectableYears[index]))
                            .font(font: .largeText)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: geometry.size.width / 2, height: 120).clipped()
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
                    Icon(.select)
                        .frame(width: 24, height: 24)
                }
                .padding(.top, 16)
                .padding(.bottom, 28)
                .padding(.horizontal, 16)
            }
            .contentShape(Rectangle())
            .simultaneousGesture(
                TapGesture().onEnded { _ in
                    withAnimation(Animation.easeIn.delay(delay)) {
                        delay = isPickerVisible ? 0 : 0.15
                        isPickerVisible.toggle()
                    }
                    onTap()
                }
            )
            Divider()
                .frame(height: 1)
            VStack(spacing: 0) {
                if isPickerVisible {
                    HStack(alignment: .center, spacing: 0) {
                        monthYearPicker
                            .onAppear {
                                viewModel.monthIndex = viewModel.monthIndex < 0 ? 0 : viewModel.monthIndex
                                viewModel.yearIndex = viewModel.yearIndex < 0 ? 0 : viewModel.yearIndex
                                selectedValue = formattedMonthYearString()
                            }
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 120)
                    Divider()
                        .frame(height: 1)
                }
            }
            .contentShape(Rectangle())
            .animation(Animation.easeIn.delay(delay), value: isPickerVisible)
        }
    }

    func monthChanged(_ index: Int) {
        selectedValue = formattedMonthYearString()
        onChangedDate()
    }

    func yearChanged(_ index: Int) {
        selectedValue = formattedMonthYearString()
        onChangedDate()
    }

    func formattedMonthYearString() -> String {
        return "\(viewModel.monthSymbols[viewModel.monthIndex].firstUppercased) \(viewModel.selectableYears[viewModel.yearIndex])"
    }

    // MARK: Private

    @State private var isPickerVisible = false
    @State private var delay: Double = 0
}

// MARK: - MonthYearPicker_Previews

struct MonthYearPicker_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MonthYearPickerViewModel()
        MonthYearPickerFieldView(viewModel: viewModel, selectedValue: Binding<String>.constant(""))
    }
}
