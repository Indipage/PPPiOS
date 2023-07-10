//
//  TicketCheckQRCodeViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/10.
//

import AVFoundation
import UIKit


final class TicketCheckQRCodeViewController: BaseViewController {
    
    //MARK: - Properties
    
    var qrManager: QRManager
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    //MARK: - Life Cycle
    
    init(qrManager: QRManager) {
        self.qrManager = qrManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.qrManager.setCamera()
        
        delegate()
        layout()
        layoutLabel()
    }
    
    
    
    
    //MARK: - Custom Method
    
    private func delegate() {
        self.qrManager.captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        self.qrManager.captureMetadataOutput.rectOfInterest = setVideoLayer(rectOfInterest: Size.qrFocusZone)
    }
    
    private func layout() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: QRManager.captureSession)
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
        let readingRect = Size.qrFocusZone
        let previewLayer = AVCaptureVideoPreviewLayer(session: QRManager.captureSession) // AVCaptureVideoPreviewLayer를 구성.
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = self.view.layer.bounds
        
        // MARK: - Scan Focus Mask
        
        let path = CGMutablePath()
        path.addRect(view.bounds)
        path.addRoundedRect(in: readingRect, cornerWidth: 27, cornerHeight: 27)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path
        maskLayer.fillColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        maskLayer.fillRule = .evenOdd
        
        previewLayer.addSublayer(maskLayer)
        
        
        self.view.layer.addSublayer(previewLayer)
        self.videoPreviewLayer = previewLayer
    }
    
    private func layoutLabel() {
        let describeLabel = UILabel()
        describeLabel.do {
            $0.text = "서점 내 QR 코드를 스캔해보세요 !"
        }
        self.view.addSubview(describeLabel)
        describeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(173)
            $0.centerX.equalToSuperview()
        }
        
}
        
        
        //카메라 인식 관련
        private func setVideoLayer(rectOfInterest: CGRect) -> CGRect{
            let videoLayer = AVCaptureVideoPreviewLayer(session: QRManager.captureSession) // 영상을 담을 공간.
            videoLayer.frame = view.layer.bounds //카메라의 크기 지정
            videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill //카메라의 비율지정
            view.layer.addSublayer(videoLayer)
            
            return videoLayer.metadataOutputRectConverted(fromLayerRect: rectOfInterest)
        }
    }
