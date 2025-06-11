//
//  FormGroupView.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 10/06/25.
//

import SwiftUI

struct FormGroupView: View {
    @Environment(\.modelContext) var modelContext
    @ObservedObject var presenter: FormGroupPresenter
    
    var body: some View {
        VStack {
            Text(FormGroupStrings.textTitleFormGroupView)
                .font(.title2)
                .padding()
            AppTextField(text: presenter.bindingName,
                         isValidate: .constant(true),
                         placeHolder: FormGroupStrings.textFieldPlaceholderGroupName)
            Spacer()
            Button {
                presenter.saveGruoup()
            } label: {
                Text(FormGroupStrings.buttonTitleAddGroup)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundStyle(.white)
            }
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.blue)
            )
        }
        .padding(20)
        .presentationDetents(presenter.getPresentationDetent())
        .presentationDragIndicator(.visible)
    }
}
