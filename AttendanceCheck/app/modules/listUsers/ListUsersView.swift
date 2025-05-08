//
//  ListUsersView.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 08/05/25.
//

import SwiftUI
import SwiftData

struct ListUsersView: View {
    
    @State private var users: [User] = []
    
    let presenter: ListUserPresenter
    
    init(presenter: ListUserPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(users) { user in
                    Text(user.name)
                }
            }
            Button{
                let user = User(name: "Gerardo", phone: "5529871231", email: "geraldosantillan@gmail.com")
                presenter.saveUser(user)
                users = presenter.getUsers()
            } label: {
                Text("Agregar")
            }
        }
        .onAppear {
            users = presenter.getUsers()
        }
    }
}
