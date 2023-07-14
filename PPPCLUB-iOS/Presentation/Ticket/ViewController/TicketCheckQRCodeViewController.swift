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
        self.qrManager.setCamera()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate()
        
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        QRManager.start()
    }
    
    //MARK: - Custom Method
    
    private func delegate() {
        QRManager.captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        QRManager.captureMetadataOutput.rectOfInterest = setVideoLayer(rectOfInterest: Size.qrFocusZone)
    }
    
    private func layout() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: QRManager.captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        self.videoPreviewLayer?.frame = self.view.layer.bounds
        self.view.layer.addSublayer(self.videoPreviewLayer!)
        setPreviewLayer()
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
            QRManager.stop()
            
            pushTicketResultView(result: qrCodeStringData)
        }
    }
}

extension TicketCheckQRCodeViewController {
    private func setVideoLayer(rectOfInterest: CGRect) -> CGRect {
        let videoLayer = AVCaptureVideoPreviewLayer(session: QRManager.captureSession) // 영상을 담을 공간.
        videoLayer.frame = view.layer.bounds //카메라의 크기 지정
        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill //카메라의 비율지정
        view.layer.addSublayer(videoLayer)
        
        return videoLayer.metadataOutputRectConverted(fromLayerRect: rectOfInterest)
    }
    
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
        
        let describeLabel = UILabel()
        describeLabel.do {
            $0.text = "QR코드를 인식해보세요!"
            $0.textColor = .pppWhite
            $0.font = .pppSubHead1
        }
        
        lazy var button = UIButton()
        button.do {
            $0.backgroundColor = .blue
            $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        }
        
        self.view.addSubviews(describeLabel, button)
        describeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(173)
            $0.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.top.equalToSuperview().offset(250)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
    }
    
    private func pushTicketResultView(result: String) {
        if result == "http://en.m.wikipedia.org" {
            let ticketSuccessView = TicketSuccessViewController()
            self.navigationController?.pushViewController(ticketSuccessView, animated: true)
        } else {
            let ticketFailView = TicketFailureViewController()
            ticketFailView.delagate = self
            self.modalPresentationStyle = .fullScreen
            self.present(ticketFailView, animated: true)
        }
    }
    
    @objc func backButtonDidTap() {
        QRManager.stop()
        self.navigationController?.popViewController(animated: true)
    }
}

extension TicketCheckQRCodeViewController: ExitButtonDelegate {
    func exitButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
}
