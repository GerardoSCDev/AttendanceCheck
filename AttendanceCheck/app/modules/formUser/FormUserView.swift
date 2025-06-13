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
            Text(FormUserStrings.formUserTitle)
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
                    
                    AppTextField(text: presenter.bindingName,
                                 isValidate: presenter.bindingIsValidateName,
                                 placeHolder: FormUserStrings.textFieldPlaceholderName,
                                 rules: [.notEmpty])
                    
                    AppTextField(text: presenter.bindingLastName,
                                 isValidate: presenter.bindingIsValidateLastName,
                                 placeHolder: FormUserStrings.textFieldPlaceholderLastName,
                                 rules: [.notEmpty])
                    
                    AppTextField(text: presenter.bindingEmail,
                                 isValidate: presenter.bindingIsValidateEmail,
                                 placeHolder: FormUserStrings.textFieldPlaceholderEmail,
                                 rules: [.notEmpty, .emailFormat],
                                 keyBoardType: .emailAddress,
                                 autocapitalization: UITextAutocapitalizationType.none)
                    
                    AppTextField(text: presenter.bindingPhone,
                                 isValidate: presenter.bindingIsValidadePhone,
                                 placeHolder: FormUserStrings.textFieldPlaceholderPhone,
                                 rules: [.notEmpty, .phoneLimitDigits],
                                 keyBoardType: .asciiCapableNumberPad)
                    
                    AppTextField(text: presenter.bindingEge,
                                 isValidate: presenter.bindingIsValidateEge,
                                 placeHolder: FormUserStrings.textFieldPlaceholderAge,
                                 rules: [.notEmpty, .limitDigits(3)],
                                 keyBoardType: .asciiCapableNumberPad)
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
        .presentationDragIndicator(.visible)
        
    }
}
