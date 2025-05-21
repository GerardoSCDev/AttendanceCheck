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
}

class ListUserPresenter: ObservableObject {
    @Published var users: [User] = []
    @Published var showFormModal: Bool = false
    
    var bindingShowFormModal: Binding<Bool> {
        .init(get: { self.showFormModal },
              set: { self.showFormModal = $0 })
    }
    
    var interactor: ListUserInteractorProtocol
    
    init(interactor: ListUserInteractor) {
        self.interactor = interactor
    }
    
}

extension ListUserPresenter: ListUserPrsenterProtocol {
    func showModalToggle() {
        showFormModal.toggle()
    }
    
    func reloadListUsers() {
        do {
            users = try interactor.fetchAll()
        } catch {
            print("Error al obtener usuarios: \(error)")
        }
    }
    
}
