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
            if presenter.allUsersIsEmpty() {
                VStack(alignment: .center) {
                    Image("emptyUsers")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text(ListUsersStrings.emptyUsersListTitle)
                        .font(.title2)
                }
            } else {
                
                AppTextField(text: presenter.bindingSearchUsers,
                             isValidate: .constant(true),
                             icon: Image(systemName: "person.crop.badge.magnifyingglass"),
                             placeHolder: ListUsersStrings.searchUserPlaceholder) { _, _ in
                    presenter.findUsersByName(name: presenter.searchUsers)
                }
                
                HStack {
                    ListUserFilterOptionsView() { typeSelected in
                        presenter.findUsersByFilterOption(type: typeSelected)
                    }
                    AppDatePickerButton() { newDate in
                        presenter.findUsersByDate(date: newDate)
                    }
                }
                .padding(.top, 15)
            }
            
            List {
                if presenter.users.isEmpty {
                    VStack(alignment: .center) {
                        Image("emptyUsers")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250, height: 250)
                        Text(ListUsersStrings.noResultsUsersListTitle)
                            .font(.title2)
                    }
                } else {
                    ForEach(presenter.users) { user in
                        NavigationLink {
                            Text(user.name)
                        } label: {
                            UserItemView(user: user)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle(
                presenter.users.isEmpty ?
                    Text("") :
                    Text(ListUsersStrings.navigationTitle)
            )
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                Button {
                    presenter.showModalToggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .bold))
                }.sheet(isPresented: presenter.bindingShowFormModal) {
                    FormUserRouter.goToFormUser(modelContext: modelContext, delegate: presenter)
                }

            }
            
        }
        .onAppear {
            presenter.reloadListUsers()
        }
        
    }
}
