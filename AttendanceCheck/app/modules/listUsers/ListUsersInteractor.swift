//
//  ListUserInteractor.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 08/05/25.
//

import SwiftData
import SwiftUI

protocol ListUserInteractorProtocol {
    func insert(user: User)
    func fetchAll() throws -> [User]
}

class ListUserInteractor {
    
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
}

extension ListUserInteractor: ListUserInteractorProtocol {
    func fetchAll() throws -> [User] {
        let descriptor = FetchDescriptor<User>()
        return try modelContext.fetch(descriptor)
    }
    
    
    func insert(user: User) {
        modelContext.insert(user)
    }
    
    
}
