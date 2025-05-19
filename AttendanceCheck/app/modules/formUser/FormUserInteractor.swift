//
//  FormUserInteractor.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 08/05/25.
//

import Foundation
import SwiftData

protocol FormUserInteractorProtocol {
    func insertUser(name: String, email: String, phone: String, lastName: String, ege: Int)
}

class FormUserInteractor {
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}

extension FormUserInteractor: FormUserInteractorProtocol {
    func insertUser(name: String, email: String, phone: String, lastName: String, ege: Int) {
        let newUser = User(name: name, phone: phone, email: email, lastName: lastName, ege: ege)
        modelContext.insert(newUser)
    }
}
