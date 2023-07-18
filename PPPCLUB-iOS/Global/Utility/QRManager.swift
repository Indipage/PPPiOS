//
//  QRManager.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/11.
//

import AVFoundation
import UIKit

final class QRManager {
    static let shared = QRManager()
    
    //var videoPreviewLayer = AVCaptureVideoPreviewLayer(session: QRManager.shared.captureSession)
    var captureSession = AVCaptureSession()
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
                if QRManager.shared.captureSession.canAddInput(input) { QRManager.shared.captureSession.addInput(input) }
            } catch {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func initCameraOutputData() {
        if QRManager.shared.captureSession.canAddOutput(QRManager.shared.captureMetadataOutput) {
            QRManager.shared.captureSession.addOutput(QRManager.shared.captureMetadataOutput)
        }
        //         captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr] // Camera로 들어오는 데이터 타입이 QR코드 임을 명시
        if QRManager.shared.captureMetadataOutput.availableMetadataObjectTypes.contains(AVMetadataObject.ObjectType.qr) {
            QRManager.shared.captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        } else {
            print("QR code metadata is not supported")
            // 다른 조치를 취하거나 오류 처리를 수행해야 할 수 있습니다.
        }
    }
    
    func start() {
        print("# AVCaptureSession Start Running")
        DispatchQueue.global(qos: .userInitiated).async {
            print("🔫시작했습니다🔫")
            QRManager.shared.captureSession.startRunning()
        }
    }
    
    func stop() {
        QRManager.shared.captureSession.stopRunning()
    }
    
    
    func setCamera() {
        initCameraDevice()
        initCameraInputData()
        initCameraOutputData()
    }
}
