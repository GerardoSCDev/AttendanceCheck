//
//  FormuserPresenter.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 08/05/25.
//

protocol FormUserPrsenterProtocol {
    func saveUser(name: String, email: String, phone: String)
}

class FormUserPresenter {
    private var interactor: FormUserInteractor
    
    init(interactor: FormUserInteractor) {
        self.interactor = interactor
    }
}

extension FormUserPresenter: FormUserPrsenterProtocol {
    func saveUser(name: String, email: String, phone: String) {
        interactor.insertUser(name: name, email: email, phone: phone)
    }
}
