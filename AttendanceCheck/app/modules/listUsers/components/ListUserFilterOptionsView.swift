//
//  ListUserFilterOptionsView.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 27/05/25.
//

import SwiftUI

struct OptionsFilterOptionButton: Identifiable {
    var id: Int = UUID().hashValue
    var title: String
    var selected: Bool
    var type: TypeOption
    
    enum TypeOption {
        case all, attendance, noAttendance, active, inactive
    }
}

struct ListUserFilterOptionsView: View {
    
    @State var options: [OptionsFilterOptionButton] = [
        .init(title: "Todos", selected: true, type: .all),
        .init(title: "Asistencia", selected: false, type: .attendance),
        .init(title: "Inasistencia", selected: false, type: .noAttendance),
        .init(title: "Activo", selected: false, type: .active),
        .init(title: "Inactivo", selected: false, type: .inactive)
    ]
    
    var onChangeSelection: ((OptionsFilterOptionButton.TypeOption) -> Void)?
    
    private func unselectAllOptions() {
        for i in options.indices {
            options[i].selected = false
        }
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(options.indices, id: \.self) { index in
                    AppFilterOptionButton(title: options[index].title, selected: options[index].selected) {
                        unselectAllOptions()
                        options[index].selected = true
                        onChangeSelection?(options[index].type)
                    }
                }
            }
        }
        .padding(.top, 15)
    }
}
