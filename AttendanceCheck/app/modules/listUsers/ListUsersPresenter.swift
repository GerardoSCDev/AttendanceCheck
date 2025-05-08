//
//  ListUserPresenter.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 08/05/25.
//

import SwiftData
import SwiftUI

protocol ListUserPrsenterProtocol {
    func getUsers() -> [User]
    func saveUser(_ user: User)
}

class ListUserPresenter {
    
    var interactor: ListUserInteractorProtocol
    
    init(interactor: ListUserInteractor) {
        self.interactor = interactor
    }
    
}

extension ListUserPresenter: ListUserPrsenterProtocol {
    func getUsers() -> [User] {
        return try! interactor.fetchAll()
    }
    
    func saveUser(_ user: User) {
        let newUser = User(name: "Gerardo", phone: "5529871231", email: "geraldosantillan@gmail.com")
        interactor.insert(user: newUser)
    }
    
    
}
