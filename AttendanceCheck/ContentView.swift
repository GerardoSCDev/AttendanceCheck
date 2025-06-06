//
//  ContentView.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 08/05/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    var body: some View {
        let interactor = ListUserInteractor(modelContext: modelContext)
        let presenter = ListUserPresenter(interactor: interactor)
        ListUsersView(presenter: presenter)
    }
}

#Preview {
    ContentView()
}
