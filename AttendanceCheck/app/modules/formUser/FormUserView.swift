//
//  FormUserView.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 08/05/25.
//

import SwiftUI

struct FormUserView: View {
    
    @ObservedObject var presenter: FormUserPresenter
    
    init(presenter: FormUserPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        VStack {
            Capsule()
                .frame(width: 100, height: 4)
                .foregroundStyle(.white)
            Text("Formulario usuario")
                .font(.title2)
                .padding()
            ScrollView {
                VStack(spacing: 30) {
                    ZStack {
                        if presenter.photoImage == nil {
                            CameraPreviewView(session: presenter.cameraManager.captureSession)
                                .frame(width: 220, height: 220)
                                .cornerRadius(20)
                                .clipped()
                                .shadow(radius: 5)
                        }
                        
                        if let photo = presenter.bindingPhotoImage.wrappedValue {
                            Image(uiImage: photo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 220, height: 220)
                                .cornerRadius(20)
                                .clipped()
                        }
                        
                        VStack {
                            Spacer()
                            if let _ = presenter.bindingPhotoImage.wrappedValue {
                                Button {
                                    presenter.resetTakePhoto()
                                } label: {
                                    Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.camera")
                                        .font(.system(size: 30, weight: .bold))
                                }.padding(10)
                            } else {
                                Button {
                                    presenter.takePhoto()
                                } label: {
                                    Image(systemName: "camera.circle.fill")
                                        .font(.system(size: 30, weight: .bold))
                                }.padding(10)
                            }
                            
                        }
                        
                    }
                    
                    HStack {
                        TextField(FormUserStrings.textFieldPlaceholderName, text: presenter.bindingName)
                            .onChange(of: presenter.name) { _, _ in
                                presenter.validateField()
                            }
                    }
                    .textFieldStyle(OutlinedTextFieldStyle())
                    HStack {
                        TextField(FormUserStrings.textFieldPlaceholderLastName, text: presenter.bindingLastName)
                            .onChange(of: presenter.lastName) { _, _ in
                                presenter.validateField()
                            }
                    }
                    .textFieldStyle(OutlinedTextFieldStyle())
                    HStack {
                        TextField(FormUserStrings.textFieldPlaceholderEmail, text: presenter.bindingEmail)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .onChange(of: presenter.email) { _, _ in
                                presenter.validateField()
                            }
                    }
                    .textFieldStyle(OutlinedTextFieldStyle())
                    HStack {
                        TextField(FormUserStrings.textFieldPlaceholderPhone, text: presenter.bindingPhone)
                            .keyboardType(.asciiCapableNumberPad)
                            .onChange(of: presenter.phone) { _, _ in
                                presenter.validateField()
                            }
                    }
                    .textFieldStyle(OutlinedTextFieldStyle())
                    HStack {
                        TextField(FormUserStrings.textFieldPlaceholderAge, text: presenter.bindingEge)
                            .keyboardType(.asciiCapableNumberPad)
                            .onChange(of: presenter.ege) { _, _ in
                                presenter.validateField()
                            }
                    }
                    .textFieldStyle(OutlinedTextFieldStyle())
                }
            }
            .padding(.bottom, 20)
            Button {
                presenter.saveUser()
            } label: {
                Text(FormUserStrings.actionButtonTitle)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundStyle(.white)
            }
            .disabled(!presenter.isValidateForm)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(presenter.isValidateForm ? Color.blue : Color.gray)
            )
        }
        .padding()
        
    }
}
