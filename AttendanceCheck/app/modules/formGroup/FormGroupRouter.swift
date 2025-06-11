//
//  FormGroupRouter.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 10/06/25.
//

import SwiftData
import SwiftUI

class FormGroupRouter {
    static func goToFormGroup(modelContext: ModelContext, delegate: ListUserPrsenterProtocol) -> some View {
        let interactor = FormGrupoInteractor(modelContext: modelContext)
        let presenter = FormGroupPresenter(interactor: interactor)
        presenter.delegate = delegate
        return FormGroupView(presenter: presenter)
    }
}
