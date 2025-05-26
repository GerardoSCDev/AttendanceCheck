//
//  AppFilterOptionButton.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 26/05/25.
//

import SwiftUI

struct AppFilterOptionButton: View {
    
    let title: String
    let selected: Bool?
    
    var body: some View {
        Button {
            
        } label: {
            Text(title)
                .frame(height: 40)
                .foregroundStyle(.white.opacity(selected ?? true ? 1 : 0.3))
                .padding(.horizontal)
                .font(.system(size: 14))
        }
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(.blue.opacity(selected ?? true ? 1 : 0.3))
        )
    }
}
