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
    func fetchAllUsers() throws -> [User]
    func fetchAllGroups() throws -> [Groups]
}

class ListUserInteractor {
    
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}

extension ListUserInteractor: ListUserInteractorProtocol {
    func fetchAllGroups() throws -> [Groups] {
        let descriptor = FetchDescriptor<Groups>()
        return try modelContext.fetch(descriptor)
    }
    
    func fetchAllUsers() throws -> [User] {
        let descriptor = FetchDescriptor<User>()
        return try modelContext.fetch(descriptor)
    }
    
    func insert(user: User) {
        modelContext.insert(user)
    }
}
