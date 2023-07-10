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
    
    private var cornerLength: CGFloat = 20
    private var cornerLineWidth: CGFloat = 6
    
    private var rectOfInterest: CGRect {
        CGRect(x: (UIScreen.main.bounds.width - 200) / 2 , y: (UIScreen.main.bounds.height - 200) / 2, width: 200, height: 200)
    }
    
    // 당연히 지금까지는 Delegate에 대한 프로토콜을 채택하지 않았기 때문에, 빨간 줄이 뜰 것입니다.
    func delegate() {
        self.qrManager.captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main) // Output 데이터가 들어왔을 때, 처리할 Delegate 설정
        self.qrManager.captureMetadataOutput.rectOfInterest = setVideoLayer(rectOfInterest: rectOfInterest)
    }
    
    private func displayPreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: qrManager.captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        self.videoPreviewLayer?.frame = self.view.layer.bounds
        self.view.layer.addSublayer(self.videoPreviewLayer!)
        setPreviewLayer() // 중앙에 사각형의 Focus Zone Layer을 설정합니다.
        self.start() // startRunning을 실행시켜야 화면이 보이게 됩니다.
        
    }
    
    override func viewDidLoad() {
        self.qrManager.setCamera()
        delegate()
        displayPreview()
    }
    
    //MARK: - Custom Method
    
}

extension TicketCheckQRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    // MetaData가 들어올 때마다 실행되는 메소드
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        print(#function)
        
        // MetaData을 사람이 읽을 수 있는 Data로 캐스팅
        guard let metaDataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else {
            print("Fail to cast MetaData as AVMetadataMachineReadableCodeObject")
            return
        }
        
        // QR 데이터인 경우
        if metaDataObj.type == .qr {
            print("qr이 맞습니다!🔫🔫🔫🔫🔫🔫🔫🔫🔫🔫")
            
            // 여기서 직접적으로 가져온 QR Code 데이터를 해독한다.
            guard let qrCodeStringData = metaDataObj.stringValue else { return }
            
            print(qrCodeStringData)
            self.stop(isButtonTap: true)
        }
    }
}

extension TicketCheckQRCodeViewController {
    func start() {
        print("# AVCaptureSession Start Running")
        DispatchQueue.global(qos: .userInitiated).async {
            print("🔫시작했습니다🔫")
            self.qrManager.captureSession.startRunning()
        }
    }
    
    func stop(isButtonTap: Bool) {
        self.qrManager.captureSession.stopRunning()
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

internal extension CGPoint {
    
    // MARK: - CGPoint+offsetBy
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        var point = self
        point.x += dx
        point.y += dy
        return point
    }
}
