//
//  QRManager.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/11.
//

import AVFoundation
import UIKit

final class QRManager {
    static var videoPreviewLayer = AVCaptureVideoPreviewLayer(session: QRManager.captureSession)
    static var captureSession = AVCaptureSession()
    var cameraDevice: AVCaptureDevice?
    let captureMetadataOutput = AVCaptureMetadataOutput()
    
    // 카메라 장치 설정 - 뒷면으로 설정
    func initCameraDevice() {
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Failed to get the camera device")
            return
        }
        cameraDevice = captureDevice
    }
    
    // 카메라 Input 설정
    func initCameraInputData() {
        if let cameraDevice = self.cameraDevice {
            do {
                let input = try AVCaptureDeviceInput(device: cameraDevice)
                if QRManager.captureSession.canAddInput(input) { QRManager.captureSession.addInput(input) }
            } catch {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func initCameraOutputData() {
        if QRManager.captureSession.canAddOutput(captureMetadataOutput) {
            QRManager.captureSession.addOutput(captureMetadataOutput)
        }
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr] // Camera로 들어오는 데이터 타입이 QR코드 임을 명시
    }
    
    func start() {
        print("# AVCaptureSession Start Running")
        DispatchQueue.global(qos: .userInitiated).async {
            print("🔫시작했습니다🔫")
            QRManager.captureSession.startRunning()
        }
    }
    
    func stop() {
        QRManager.captureSession.stopRunning()
    }
    
    
    func setCamera() {
        initCameraDevice()
        initCameraInputData()
        initCameraOutputData()
    }
}
