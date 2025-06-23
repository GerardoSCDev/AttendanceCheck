//
//  AppComboBoxField.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan on 18/06/25.
//

import SwiftUI

struct AppComboBoxField<T: Identifiable & Equatable>: View {
    @State private var isExpandedBottomSheet = false
    @Binding var selected: T?
    @Binding var isValidate: Bool
    
    var options: [T]
    var placeHolder: String
    var displayText: (T) -> String
    var enableEmptyOption: Bool?
    var rules: [AppComboBoxFieldRules]?
    
    var body: some View {
        VStack {
            Button(action: {
                isExpandedBottomSheet.toggle()
            }) {
                HStack {
                    Text(selected.map(displayText) ?? placeHolder)
                        .foregroundColor(selected == nil ? .gray : .primary)
                        .onChange(of: selected) { oldValue, newValue in
                            isValidate = validateText()
                        }
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(getRoundedRectangleColor(), lineWidth: 1)
                )
            }
        }
        .sheet(isPresented: $isExpandedBottomSheet) {
            VStack {
                Text(placeHolder)
                    .font(.headline)
                if let _ = enableEmptyOption {
                    Button(action: {
                        selected = nil
                        isValidate = validateText()
                        isExpandedBottomSheet = false
                    }) {
                        Text("Ninguno")
                    }
                }
                
                List(options) { item in
                    Button(action: {
                        selected = item
                        isValidate = validateText()
                        isExpandedBottomSheet = false
                    }) {
                        Text(displayText(item))
                    }
                }
            }
            .presentationDetents([.fraction(0.25)])
        }
    }
    
    private func getRoundedRectangleColor() -> Color {
        guard let _ = rules else {
            return Color.gray.opacity(0.6)
        }
        return isValidate ? Color.gray.opacity(0.6) : Color.red
    }
    
    private func validateText() -> Bool {
        if let rules = rules {
            for rule in rules {
                switch rule {
                case .noEmptySelection:
                    guard let _ = selected else {
                        return false
                    }
                }
            }
        }
        return true
    }
}

enum AppComboBoxFieldRules {
    case noEmptySelection
}
