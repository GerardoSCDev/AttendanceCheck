//
//  CameraManager.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 09/05/25.
//

import AVFoundation
import CoreImage
import Foundation
import SwiftUI

class CameraManager: NSObject {
    
    lazy var previewStream: AsyncStream<CGImage> = {
        AsyncStream { continuation in
            addToPreviewStream = { cgImage in
                continuation.yield(cgImage)
            }
        }
    }()
    
    let captureSession = AVCaptureSession()
    private var deviceInput: AVCaptureDeviceInput?
    private var videoOutput: AVCaptureVideoDataOutput?
    private let systemPreferredCamera = AVCaptureDevice.default(for: .video)
    private let photoOutput = AVCapturePhotoOutput()
    private var sessionQueue = DispatchQueue(label: "video.preview.session")
    private var addToPreviewStream: ((CGImage) -> Void)?
    
    var onPhotoCapture: ((UIImage) -> Void)?
    
    override init() {
        super.init()
        Task {
            await configureSession()
            await startSession()
        }
    }
    
    private func configureSession() async {
        guard await isAuthorized,
              let systemPreferredCamera,
              let deviceInput = try? AVCaptureDeviceInput(device: systemPreferredCamera)
        else { return }
        captureSession.beginConfiguration()
        defer {
            self.captureSession.commitConfiguration()
        }
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: sessionQueue)
        guard captureSession.canAddInput(deviceInput) else {
            print("Unable to add device input to capture session.")
            return
        }
        guard captureSession.canAddOutput(videoOutput) else {
            print("Unable to add video output to capture session.")
            return
        }
        captureSession.addInput(deviceInput)
        captureSession.addOutput(videoOutput)
        captureSession.addOutput(photoOutput)
    }
    
    private var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            
            var isAuthorized = status == .authorized
            
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            
            return isAuthorized
        }
    }
    
    func startSession() async {
        guard await isAuthorized else { return }
        captureSession.startRunning()
    }
    
    func stopSession() {
        captureSession.stopRunning()
    }
    
    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
}

extension CameraManager: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        if let data = photo.fileDataRepresentation(),
           let image = UIImage(data: data) {
            let imageCrupped = image.squared
            let imageResized = imageCrupped?.resizeWithPercent(percentage: 0.15)!
            onPhotoCapture?(imageResized!)
        } else if let error = error {
            print("Error al capturar la foto: \(error.localizedDescription)")
        }
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        guard let currentFrame = sampleBuffer.cgImage else { return }
        addToPreviewStream?(currentFrame)
    }
}

extension CMSampleBuffer {
    
    var cgImage: CGImage? {
        let pixelBuffer: CVPixelBuffer? = CMSampleBufferGetImageBuffer(self)
        
        guard let imagePixelBuffer = pixelBuffer else {
            return nil
        }
        
        return CIImage(cvPixelBuffer: imagePixelBuffer).cgImage
    }
    
}

extension CIImage {
    var cgImage: CGImage? {
        let ciContext = CIContext()
        guard let cgImage = ciContext.createCGImage(self, from: self.extent) else {
            return nil
        }
        return cgImage
    }
}


struct CameraPreviewView: UIViewRepresentable {
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> PreviewUIView {
        let view = PreviewUIView()
        view.previewLayer.session = session
        return view
    }
    
    func updateUIView(_ uiView: PreviewUIView, context: Context) {
        
    }
    
    class PreviewUIView: UIView {
        override class var layerClass: AnyClass {
            return AVCaptureVideoPreviewLayer.self
        }
        
        var previewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            previewLayer.videoGravity = .resizeAspectFill
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
