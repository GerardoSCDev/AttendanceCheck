//
//  FormUserRouter.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 08/05/25.
//

import SwiftUI
import SwiftData

class FormUserRouter {
    static func goToFormUser(modelContext: ModelContext) -> some View {
        let interactor = FormUserInteractor(modelContext: modelContext)
        let presenter = FormUserPresenter(interactor: interactor)
        return FormUserView(presenter: presenter)
    }
}

