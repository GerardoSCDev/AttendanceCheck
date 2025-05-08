//
//  FormUserView.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 08/05/25.
//

import SwiftUI

struct FormUserView: View {
    
    let presenter: FormUserPresenter
    
    init(presenter: FormUserPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        Button {
            presenter.saveUser(name: "Karen", email: "karen@gmail.com", phone: "5598123992")
        } label: {
            Text("Agregar usuario")
        }
    }
}
