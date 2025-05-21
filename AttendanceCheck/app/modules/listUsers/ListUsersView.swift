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
            if presenter.users.isEmpty {
                VStack(alignment: .center) {
                    Image("emptyUsers")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text("No hay usuarios agregados")
                        .font(.title2)
                }
            } else {
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
