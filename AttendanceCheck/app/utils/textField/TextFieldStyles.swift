//
//  TextFieldStyles.swift
//  myGymManager
//
//  Created by Gerardo Santillan Cruzado on 07/05/25.
//

import SwiftUI

struct OutlinedTextFieldStyle: TextFieldStyle {
    
    @State var icon: Image?
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            if icon != nil {
                icon
                    .foregroundColor(Color(UIColor.systemGray4))
            }
            configuration
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color(UIColor.systemGray4), lineWidth: 2)
        }
    }
}
