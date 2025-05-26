//
//  ListUserPresenter.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 08/05/25.
//

import SwiftData
import SwiftUI

protocol ListUserPrsenterProtocol {
    func reloadListUsers()
    func showModalToggle()
    func findUsersByName(name: String)
    func allUsersIsEmpty() -> Bool
}

class ListUserPresenter: ObservableObject {
    @Published var users: [User] = []
    @Published var showFormModal: Bool = false
    @Published var searchUsers: String = "" {
        didSet {
            findUsersByName(name: searchUsers)
        }
    }
    
    private var allUsers: [User] = []
    
    var bindingShowFormModal: Binding<Bool> {
        .init(get: { self.showFormModal },
              set: { self.showFormModal = $0 })
    }
    var bindingSearchUsers: Binding<String> {
        .init(get: { self.searchUsers },
              set: { self.searchUsers = $0 })
    }
    
    var interactor: ListUserInteractorProtocol
    
    init(interactor: ListUserInteractor) {
        self.interactor = interactor
    }
    
}

extension ListUserPresenter: ListUserPrsenterProtocol {
    func allUsersIsEmpty() -> Bool {
        return allUsers.isEmpty
    }
    
    func findUsersByName(name: String) {
        if name.isEmpty {
            users = allUsers
        } else {
            users = allUsers.filter { $0.name.localizedCaseInsensitiveContains(name) }
        }
    }
    
    func showModalToggle() {
        showFormModal.toggle()
    }
    
    func reloadListUsers() {
        do {
            let fetchedUsers = try interactor.fetchAll()
            allUsers = fetchedUsers
            users = fetchedUsers
        } catch {
            print("Error al obtener usuarios: \(error)")
        }
    }
    
}
