//
//  PickerFieldView.swift
//  Marginalen
//
//  Created by michaelst on 2021-06-02.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

// MARK: - PickerFieldView

struct PickerFieldView: View {
    @ObservedObject var viewModel: PickerFieldViewModel
    @Binding var selectedValue: String
    var onTap: (() -> Void) = {}
    @State private var isPickerVisible = false
    @State private var delay: Double = 0
    var onChange: ((String) -> Void)?

    init(viewModel: PickerFieldViewModel,
         selectedValue: Binding<String>,
         onTap: @escaping (() -> Void) = {},
         onChangedValue: @escaping (() -> Void) = {}) {
        self.viewModel = viewModel
        self._selectedValue = selectedValue
        self.onTap = onTap
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
                .frame(height: 20)
            Spacer()
        }
    }

    var picker: some View {
        Picker("", selection: $selectedValue) {
            ForEach(viewModel.values, id: \.self) {
                Text($0)
                    .font(font: .largeText)
            }
        }
        .onChange(of: selectedValue, perform: { onChange?($0) })
        .pickerStyle(WheelPickerStyle())
        .labelsHidden()
        .frame(height: 120)
        .clipped()
        .onAppear {
            if selectedValue.isEmpty {
                selectedValue = viewModel.defaultValue.isEmpty ? viewModel.values[0] : viewModel.defaultValue
            }
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(spacing: 4) {
                    labelView
                    textView
                }
                .padding(.vertical, 20)
                Icon(.select)
                    .frame(width: 24, height: 24)
            }
            .padding(.horizontal, 16)
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
            VStack(alignment: .center, spacing: 0) {
                if isPickerVisible {
                    picker
                    Divider()
                        .frame(height: 1)
                }
            }
            .contentShape(Rectangle())
            .animation(Animation.spring().delay(delay), value: isPickerVisible)
        }
    }
}

// MARK: - PickerFieldView_Previews

struct PickerFieldView_Previews: PreviewProvider {
    static var viewModel: PickerFieldViewModel {
        let viewModel = PickerFieldViewModel()
        viewModel.label = "Label"
        viewModel.values = ["First", "Second", "Third"]
        return viewModel
    }

    @State static var value = "Value"

    static var previews: some View {
        VStack(spacing: 0) {
            Divider()
            PickerFieldView(viewModel: viewModel,
                            selectedValue: $value)
        }
    }
}
