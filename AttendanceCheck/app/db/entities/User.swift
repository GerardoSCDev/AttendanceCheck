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
    var lastName: String
    var phone: String
    var email: String
    var ege: Int
    var isActive: Bool
    @Attribute(.externalStorage)
    var photo: Data?
    
    @Relationship var groups: [Groups]
    
    init(id: UUID = .init(), name: String, phone: String, email: String, lastName: String, ege: Int, isActive: Bool = true, photo: Data? = nil, groups: [Groups] = []) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.lastName = lastName
        self.ege = ege
        self.isActive = isActive
        self.photo = photo
        self.groups = groups
    }
}
