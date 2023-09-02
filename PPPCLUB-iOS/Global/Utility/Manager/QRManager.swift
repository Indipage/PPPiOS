//
//  QRManager.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/11.
//

import AVFoundation
import UIKit

protocol QRManagerInput {
    var captureSession: AVCaptureSession { get }
    var cameraDevice: AVCaptureDevice? { get }
    var captureMetadataOutput: AVCaptureMetadataOutput { get }
    var videoPreviewLayer: AVCaptureVideoPreviewLayer? { get }
    
    func initCameraDevice()
    func initCameraInputData()
    func initCameraOutputData()
    func initVideoPreviewLayer()
}

protocol QRManagerOutput {
    func setCamaera()
    func start()
    func stop()
}

typealias QRManagering = QRManagerInput & QRManagerOutput

final class QRManager: QRManagering {
    var captureSession: AVCaptureSession = AVCaptureSession()
    var cameraDevice: AVCaptureDevice?
    var captureMetadataOutput: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    func initCameraDevice() {
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Failed to get the camera device")
            return
        }
        cameraDevice = captureDevice
    }
    
    func initCameraInputData() {
        if let cameraDevice = self.cameraDevice {
            do {
                let input = try AVCaptureDeviceInput(device: cameraDevice)
                if captureSession.canAddInput(input) { captureSession.addInput(input) }
            } catch {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func initCameraOutputData() {
        if captureSession.canAddOutput(captureMetadataOutput) {
            captureSession.addOutput(captureMetadataOutput)
        }
        if captureMetadataOutput.availableMetadataObjectTypes.contains(AVMetadataObject.ObjectType.qr) {
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        } else {
            print("QR code metadata is not supported")
        }
    }
    
    func initVideoPreviewLayer() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
    }
    
    func setCamaera() {
        initCameraDevice()
        initCameraInputData()
        initCameraOutputData()
        initVideoPreviewLayer()
    }
    
    func start() {
        print("# AVCaptureSession Start Running")
        DispatchQueue.global(qos: .userInitiated).async {
            print("🔫시작했습니다🔫")
            self.captureSession.startRunning()
        }
    }
    
    func stop() {
        captureSession.stopRunning()
    }
}
