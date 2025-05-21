//
//  AppTextField.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 20/05/25.
//

import SwiftUI

struct AppTextField: View {
    
    @Binding var text: String
    @Binding var isValidate: Bool
    @State private var hasInteracted: Bool = false
    var icon: Image?
    var placeHolder: String?
    var rules: [AppTextFieldRules]?
    var keyBoardType: UIKeyboardType?
    var autocapitalization: UITextAutocapitalizationType?
    
    var body: some View {
        HStack {
            TextField(placeHolder ?? "", text: $text)
                .keyboardType(keyBoardType ?? .default)
                .autocapitalization(autocapitalization ?? .sentences)
                .onChange(of: text) { oldValue, newValue in
                    if !hasInteracted {
                        hasInteracted = true
                    }
                    isValidate = validateText(newValue)
                }
        }
        .textFieldStyle(OutlinedTextFieldStyle(icon: icon,
                                               showRedRectangle: hasInteracted && !isValidate))
    }
    
    private func validateText(_ value: String) -> Bool {
        if let rules = rules {
            for rule in rules {
                switch rule {
                case .notEmpty:
                    if value.isEmpty { return false }
                case .emailFormat:
                    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
                    let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                    return (!predicate.evaluate(with: value))
                case .phoneLimitDigits:
                    return (value.count != 10)
                case .limitDigits(let limit):
                    return (value.count > limit)
                }
            }
        }
        return true
    }
}


enum AppTextFieldRules {
    case notEmpty,
         emailFormat,
         phoneLimitDigits,
         limitDigits(Int)
}
