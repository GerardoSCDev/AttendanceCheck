//
//  User.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 08/05/25.
//

import SwiftData
import Foundation

@Model
class User {
    @Attribute(.unique)
    var id: UUID
    var name: String
    var phone: String
    var email: String
    
    init(id: UUID = .init(), name: String, phone: String, email: String) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
    }
}
