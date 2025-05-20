//
//  FormuserPresenter.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 08/05/25.
//

import AVFoundation
import SwiftData
import SwiftUI

protocol FormUserPrsenterProtocol {
    func saveUser()
    func takePhoto()
    func resetTakePhoto()
}

class FormUserPresenter: ObservableObject {
    private var interactor: FormUserInteractor
    
    @Published var name: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var ege: String = ""
    @Published var image: CGImage?
    @Published var photoImage: UIImage?
    
    let cameraManager = CameraManager()
    
    var bindingName: Binding<String> {
        .init(get: { self.name },
              set: { self.name = $0 })
    }
    var bindingLastName: Binding<String> {
        .init(get: { self.lastName },
              set: { self.lastName = $0 })
    }
    var bindingEmail: Binding<String> {
        .init(get: { self.email },
              set: { self.email = $0 })
    }
    var bindingPhone: Binding<String> {
        .init(get: { self.phone },
              set: { self.phone = $0 })
    }
    var bindingEge: Binding<String> {
        .init(get: { self.ege },
              set: { self.ege = $0 })
    }
    var bindingImage: Binding<CGImage?> {
        .init(get: { self.image },
              set: { self.image = $0 })
    }
    var bindingPhotoImage: Binding<UIImage?> {
        .init(get: { self.photoImage },
              set: { self.photoImage = $0 })
    }
    
    var delegate: ListUserPrsenterProtocol?
    
    init(interactor: FormUserInteractor) {
        self.interactor = interactor
        handelOnPhotoCapture()
        Task {
            await handleCameraPreviews()
        }
    }
    
    private func handelOnPhotoCapture() {
        cameraManager.onPhotoCapture = { image in
            print("Existe la foto \(self.photoImage != nil)")
            self.cameraManager.stopSession()
            self.photoImage = image
        }
    }
    
    private func handleCameraPreviews() async {
        for await image in cameraManager.previewStream {
            Task { @MainActor in
                self.image = image
            }
        }
    }
}

extension FormUserPresenter: FormUserPrsenterProtocol {
    func resetTakePhoto()  {
        photoImage = nil
        Task {
            await cameraManager.startSession()
        }
        
    }
    
    func takePhoto() {
        cameraManager.capturePhoto()
    }
    
    func saveUser() {
        interactor.insertUser(name: self.name,
                              email: self.email,
                              phone: self.phone,
                              lastName: self.lastName,
                              ege: Int(ege) ?? 0,
                              photo: photoImage?.pngData())
        delegate?.reloadListUsers()
        delegate?.showModalToggle()
    }
}


