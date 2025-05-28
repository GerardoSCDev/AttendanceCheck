//
//  AppDatePickerButton.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 28/05/25.
//

import SwiftUI

struct AppDatePickerButton: View {
    
    @State private var date = Date()
    @State private var showDatePicker: Bool = false
    
    var didDateSelect: ((Date) -> ())? = nil
    
    var body: some View {
        Button {
            showDatePicker.toggle()
        } label: {
            Text(date, format: .dateTime.day().month().year())
                .font(.system(size: 14))
                .foregroundStyle(.white)
        }
        .sheet(isPresented: $showDatePicker) {
            VStack {
                DatePicker(
                    "",
                    selection: $date,
                    in: ...Date(),
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .labelsHidden()
                .padding()
                .onChange(of: date) { oldValue, newValue in
                    didDateSelect?(newValue)
                }
                
            }
            .presentationDetents([.height(400)])
            .presentationDragIndicator(.visible)
        }
    }
}
