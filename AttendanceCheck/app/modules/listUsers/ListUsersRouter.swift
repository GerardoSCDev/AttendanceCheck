//
//  ListUsersRouter.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 08/05/25.
//

import SwiftUI
import SwiftData

class ListUsersRouter {
    static func goToListUser(modelContext: ModelContext) -> some View {
        let interactor = ListUserInteractor(modelContext: modelContext)
        let presenter = ListUserPresenter(interactor: interactor)
        return ListUsersView(presenter: presenter)
    }
}
