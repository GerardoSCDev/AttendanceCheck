//
//  FormGrupoInteractor.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 10/06/25.
//

import SwiftData

protocol FormGroupInteractorProtocol {
    func insert(group: Groups) throws
}

class FormGrupoInteractor {
    
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}

extension FormGrupoInteractor: FormGroupInteractorProtocol {
    func insert(group: Groups) throws {
        modelContext.insert(group)
        try modelContext.save()
    }
}
