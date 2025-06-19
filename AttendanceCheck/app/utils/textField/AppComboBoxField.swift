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
    @Binding var options: [T]
    
    var placeHolder: String
    var displayText: (T) -> String
    var enableEmptyOption: Bool?
    
    var body: some View {
        VStack {
            Button(action: {
                isExpandedBottomSheet.toggle()
            }) {
                HStack {
                    Text(selected.map(displayText) ?? placeHolder)
                        .foregroundColor(selected == nil ? .gray : .primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                )
            }
        }
        .sheet(isPresented: $isExpandedBottomSheet) {
            VStack {
                Text(placeHolder)
                    .font(.headline)
                Button(action: {
                    selected = nil
                    isExpandedBottomSheet = false
                }) {
                    Text("Selecciona una opción")
                }
                List(options) { item in
                    Button(action: {
                        selected = item
                        isExpandedBottomSheet = false
                    }) {
                        Text(displayText(item))
                    }
                }
            }
            .presentationDetents([.fraction(0.25)])
        }
    }
}
