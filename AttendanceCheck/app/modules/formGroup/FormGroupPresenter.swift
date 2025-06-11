//
//  FormGroupPresenter.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 10/06/25.
//

import SwiftUI

protocol FormGroupPresenterProtocol {
    func getPresentationDetent() -> Set<PresentationDetent>
    func saveGruoup()
}

class FormGroupPresenter: ObservableObject {
    @Published var name = ""
    var bindingName: Binding<String> {
        .init(get: { self.name },
              set: { self.name = $0 })
    }
    
    @Published var showFormGroupModal: Bool = false
    var bindingShowFormGrupoModal: Binding<Bool> {
        .init(get: { self.showFormGroupModal },
              set: { self.showFormGroupModal = $0 })
    }
    
    var interactor: FormGrupoInteractor
    var delegate: ListUserPrsenterProtocol?
    
    init(interactor: FormGrupoInteractor) {
        self.interactor = interactor
    }
}

extension FormGroupPresenter: FormGroupPresenterProtocol {
    func getPresentationDetent() -> Set<PresentationDetent> {
        return [.height(250)]
    }
    
    func saveGruoup() {
        let newGroup = Groups(name: name)
        do {
            try interactor.insert(group: newGroup)
            delegate?.showModalFormGroupToggle()
            delegate?.loadListGroup()
        } catch {
            print("❌ Fail: \(error.localizedDescription)")
        }
        
    }
}
