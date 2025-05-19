//
//  ListUsersView.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 08/05/25.
//

import SwiftUI
import SwiftData

struct ListUsersView: View {
    @Environment(\.modelContext) var modelContext
    @ObservedObject var presenter: ListUserPresenter
    @State var searchText = ""
    init(presenter: ListUserPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        
        NavigationStack {
            
            HStack {
                TextField(FormUserStrings.textFieldPlaceholderName, text: $searchText)
            }
            .textFieldStyle(OutlinedTextFieldStyle())
            
            HStack {
                Button {
                    
                } label: {
                    Text(FormUserStrings.actionButtonTitle)
                        .frame(maxHeight: 40)
                        .foregroundStyle(.white)
                }
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.blue)
                )
            }
            
            if presenter.users.isEmpty {
                Text("Nel no hay nada")
            }
            
            List {
                ForEach(presenter.users) { user in
                    NavigationLink {
                        Text(user.name)
                    } label: {
                        UserItemView(user: user)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle(Text(ListUsersStrings.navigationTitle))
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                let showFormModalBinding = Binding(get: { presenter.showFormModal },
                                                   set: { presenter.showFormModal = $0 })
                
                Button {
                    presenter.showModalToggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .bold))
                }.sheet(isPresented: showFormModalBinding) {
                    FormUserRouter.goToFormUser(modelContext: modelContext, delegate: presenter)
                }

            }
            
        }
        .onAppear {
            presenter.reloadListUsers()
        }
        
    }
}
