//
//  TextFieldStyles.swift
//  myGymManager
//
//  Created by Gerardo Santillan Cruzado on 07/05/25.
//

import SwiftUI

struct OutlinedTextFieldStyle: TextFieldStyle {
    var icon: Image?
    var showRedRectangle: Bool = false
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            if let icon = icon {
                icon
                    .foregroundColor(Color(UIColor.systemGray4))
            }
            configuration
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(showRedRectangle ? Color.red : Color(UIColor.systemGray4), lineWidth: 2)
        }
    }
}
