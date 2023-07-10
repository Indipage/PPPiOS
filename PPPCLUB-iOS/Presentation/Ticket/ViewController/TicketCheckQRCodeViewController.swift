//
//  TicketCheckQRCodeViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/10.
//

import UIKit
import AVFoundation

enum ReaderStatus {
    case success(_ code: String?)
    case fail
    case stop(_ isButtonTap: Bool)
}


class QRManager {
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
                if captureSession.canAddInput(input) { captureSession.addInput(input) }
            } catch {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func initCameraOutputData() {
        if self.captureSession.canAddOutput(captureMetadataOutput) {
            self.captureSession.addOutput(captureMetadataOutput)
        }
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr] // Camera로 들어오는 데이터 타입이 QR코드 임을 명시
    }
    
    func start() {
        print("# AVCaptureSession Start Running")
        DispatchQueue.global(qos: .userInitiated).async {
            print("🔫시작했습니다🔫")
            self.captureSession.startRunning()
        }
    }
    
    func stop() {
        self.captureSession.stopRunning()
    }
    
    func setCamera() {
        initCameraDevice()
        initCameraInputData()
        initCameraOutputData()
    }
}


final class TicketCheckQRCodeViewController: BaseViewController {
    
    var qrManager: QRManager
    init(qrManager: QRManager) {
        self.qrManager = qrManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?

    private var rectOfInterest: CGRect {
        CGRect(x: (Size.width - 200) / 2 , y: (Size.height - 200) / 2, width: 200, height: 200)
    }
    
    override func viewDidLoad() {
        self.qrManager.setCamera()
        
        delegate()
        layout()
    }
    
    //MARK: - Custom Method
    
    private func delegate() {
        self.qrManager.captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        self.qrManager.captureMetadataOutput.rectOfInterest = setVideoLayer(rectOfInterest: rectOfInterest)
    }
    
    private func layout() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: qrManager.captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        self.videoPreviewLayer?.frame = self.view.layer.bounds
        self.view.layer.addSublayer(self.videoPreviewLayer!)
        setPreviewLayer() // 중앙에 사각형의 Focus Zone Layer을 설정합니다.
        self.qrManager.start() // startRunning을 실행시켜야 화면이 보이게 됩니다.
    }
    
}

extension TicketCheckQRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        print(#function)
        
        guard let metaDataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else {
            print("QR인식에 실패했습니다!")
            return
        }
        
        if metaDataObj.type == .qr {
            guard let qrCodeStringData = metaDataObj.stringValue else { return }
            print("🔫qr이 맞습니다!🔫")
            print("🔫\(qrCodeStringData)🔫")
            self.qrManager.stop()
        }
    }
}

extension TicketCheckQRCodeViewController {
    /// 중앙에 사각형의 Focus Zone Layer을 설정합니다.
    private func setPreviewLayer() {
        let readingRect = rectOfInterest
        let previewLayer = AVCaptureVideoPreviewLayer(session: qrManager.captureSession) // AVCaptureVideoPreviewLayer를 구성.
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = self.view.layer.bounds
        
        // MARK: - Scan Focus Mask
        
        let path = CGMutablePath()
        path.addRect(view.bounds)
        path.addRect(readingRect)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path
        maskLayer.fillColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        maskLayer.fillRule = .evenOdd ///❓
        
        previewLayer.addSublayer(maskLayer)
        

        self.view.layer.addSublayer(previewLayer)
        self.videoPreviewLayer = previewLayer
    }
    
    
    private func setVideoLayer(rectOfInterest: CGRect) -> CGRect{
        let videoLayer = AVCaptureVideoPreviewLayer(session: qrManager.captureSession) // 영상을 담을 공간.
        videoLayer.frame = view.layer.bounds //카메라의 크기 지정
        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill //카메라의 비율지정
        view.layer.addSublayer(videoLayer)

        return videoLayer.metadataOutputRectConverted(fromLayerRect: rectOfInterest)
    }
}
