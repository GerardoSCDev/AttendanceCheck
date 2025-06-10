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
    func findUsersIsEmptyResult() -> Bool
    func findUsersByFilterOption(type: OptionsFilterOptionButton.TypeOption)
    func findUsersByDate(date: Date)
    func getUsersResult() -> [User]
}

class ListUserPresenter: ObservableObject {
    @Published var users: [User] = []
    @Published var showFormModal: Bool = false
    @Published var searchUsers: String = "" {
        didSet {
            findUsersByName(name: searchUsers)
        }
    }
    @Published var typeOptionSelected: OptionsFilterOptionButton.TypeOption = .all
    
    private var allUsers: [User] = []
    
    var bindingShowFormModal: Binding<Bool> {
        .init(get: { self.showFormModal },
              set: { self.showFormModal = $0 })
    }
    var bindingSearchUsers: Binding<String> {
        .init(get: { self.searchUsers },
              set: { self.searchUsers = $0 })
    }
    var bindingTypeOptionSelected: Binding<OptionsFilterOptionButton.TypeOption> {
        .init(get: { self.typeOptionSelected },
              set: { self.typeOptionSelected = $0 })
    }
    
    var interactor: ListUserInteractorProtocol
    
    init(interactor: ListUserInteractor) {
        self.interactor = interactor
    }
    
}

extension ListUserPresenter: ListUserPrsenterProtocol {
    func getUsersResult() -> [User] {
        return users
    }
    
    func findUsersIsEmptyResult() -> Bool {
        return users.isEmpty
    }
    
    func findUsersByDate(date: Date) {
        // TODO: fetch to BD 
    }
    
    func findUsersByFilterOption(type: OptionsFilterOptionButton.TypeOption) {
        searchUsers = ""
        switch type {
        case .all:
            users = allUsers
        case .active:
            users = allUsers.filter { $0.isActive }
        case .inactive:
            users = allUsers.filter { !$0.isActive }
        case .attendance:
            users = allUsers
        case .noAttendance:
            users = allUsers
        }
    }
    
    func allUsersIsEmpty() -> Bool {
        return allUsers.isEmpty
    }
    
    func findUsersByName(name: String) {
        if name.isEmpty {
            users = allUsers
        } else {
            users = allUsers.filter {
                $0.name.localizedCaseInsensitiveContains(name) ||
                $0.lastName.localizedCaseInsensitiveContains(name) ||
                $0.email.localizedCaseInsensitiveContains(name) ||
                $0.phone.localizedCaseInsensitiveContains(name)
            }
        }
    }
    
    func showModalToggle() {
        showFormModal.toggle()
    }
    
    func reloadListUsers() {
        do {
            let fetchedUsers = try interactor.fetchAllUsers()
            allUsers = fetchedUsers
            users = fetchedUsers
        } catch {
            print("Error al obtener usuarios: \(error)")
        }
    }
    
}
