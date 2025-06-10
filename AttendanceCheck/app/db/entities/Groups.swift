//
//  Groups.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 03/06/25.
//

import SwiftData
import Foundation

@Model
class Groups {
    @Attribute(.unique)
    var id: UUID
    var name: String
    
    @Relationship var users: [User]
    
    init(id: UUID = .init(), name: String, users: [User] = []) {
        self.id = id
        self.name = name
        self.users = users
    }
}
