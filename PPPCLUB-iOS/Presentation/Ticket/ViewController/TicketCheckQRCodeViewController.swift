//
//  TicketCheckQRCodeViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/10.
//

import AVFoundation
import UIKit

import RxSwift
import RxCocoa

final class TicketCheckQRCodeViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var viewModel: TicketCheckQRCodeViewModel
    private var qrManager: QRManager
    private let disposeBag = DisposeBag()
    
    //MARK: - Life Cycle
    
    init(viewModel: TicketCheckQRCodeViewModel, qrManager: QRManager) {
        self.viewModel = viewModel
        self.qrManager = qrManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        delegate()
        
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - Custom Method
    
    private func bind() {
        let input = TicketCheckQRCodeViewModel.Input(viewWillAppearEvent: self.rx.viewWillAppear.asObservable())
        
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
        
        self.rx.viewWillAppear.bind { _ in
            self.qrManager.start()
        }.disposed(by: disposeBag)
    }
    
    private func delegate() {
        qrManager.captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        qrManager.captureMetadataOutput.rectOfInterest = setVideoLayer(rectOfInterest: Size.qrFocusZone)
    }
    
    private func layout() {
        guard let videoPreviewLayer = qrManager.videoPreviewLayer else { return }
        videoPreviewLayer.frame = self.view.layer.bounds
        self.view.layer.addSublayer(videoPreviewLayer)
        setPreviewLayer()
    }
    
    //MARK: - Action Method
    
    @objc func backButtonDidTap() {
        qrManager.stop()
        
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - AVCaptureMetadataOutputObjectsDelegate

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
            qrManager.stop()
            guard let spaceID = viewModel.getSpaceID().value else { return }
            if extractNumberFromURL(qrCodeStringData) == "\(spaceID)" {
                print("😈알겠습니다😈")
                requestQRCodeAPI(spaceID: extractNumberFromURL(qrCodeStringData))
            } else {
                print(extractNumberFromURL(qrCodeStringData))
                presentToFailView()
            }
        }
    }
}

extension TicketCheckQRCodeViewController {
    private func setVideoLayer(rectOfInterest: CGRect) -> CGRect {
        let videoLayer = AVCaptureVideoPreviewLayer(session: qrManager.captureSession) // 영상을 담을 공간.
        videoLayer.frame = view.layer.bounds //카메라의 크기 지정
        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill //카메라의 비율지정
        view.layer.addSublayer(videoLayer)
        
        return videoLayer.metadataOutputRectConverted(fromLayerRect: rectOfInterest)
    }
    
    private func setPreviewLayer() {
        let readingRect = Size.qrFocusZone
        let previewLayer = AVCaptureVideoPreviewLayer(session: qrManager.captureSession) // AVCaptureVideoPreviewLayer를 구성.
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
        qrManager.videoPreviewLayer = previewLayer
        
        let describeLabel = UILabel()
        describeLabel.do {
            $0.text = "QR코드를 인식해보세요!"
            $0.textColor = .pppWhite
            $0.font = .pppSubHead1
        }
        
        lazy var button = BaseButton()
        button.do {
            $0.setTitle("돌아가기", for: .normal)
            $0.setTitleColor(.pppWhite, for: .normal)
            $0.titleLabel?.font = .pppBody6
            $0.setUnderline()
            $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        }
        
        self.view.addSubviews(describeLabel, button)
        describeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(173)
            $0.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.top.equalToSuperview().offset(540)
            $0.leading.equalToSuperview().offset(163)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(20)
        }
        
    }
    
    private func requestQRCodeAPI(spaceID: String?) {
        guard let spaceID = spaceID else { return }
        TicketAPI.shared.putQRCodeCheck(spaceID: spaceID) { result in
            guard let result = self.validateResult(result) as? TicketQRCodeResult else {
                self.presentToFailView()
                return
            }
            self.pushToSuccessView(imageURL: result.cardImageURL)
        }
    }
    
    private func pushToSuccessView(imageURL: String) {
        let ticketSuccessView = TicketSuccessViewController(
            viewModel: TicketViewModel(
                ticketUseCase: DefaultTicketUseCase(
                    repository: DefaultTicketRepository()
                )
            )
        )
        ticketSuccessView.dataBind(imageURL: imageURL)
        self.navigationController?.pushViewController(ticketSuccessView, animated: true)
    }
    
    private func presentToFailView() {
        let ticketFailView = TicketFailureViewController()
        ticketFailView.delagate = self
        self.modalPresentationStyle = .fullScreen
        self.present(ticketFailView, animated: true)
    }
    
    func extractNumberFromURL(_ urlString: String) -> String {
        guard let url = URL(string: urlString) else {
            return ""
        }
        
        // URL의 경로 컴포넌트를 가져옴
        let pathComponents = url.pathComponents
        
        // 경로 컴포넌트에서 "space" 다음에 오는 컴포넌트를 반환
        if let index = pathComponents.firstIndex(of: "space"), index + 1 < pathComponents.count {
            return pathComponents[index + 1]
        }
        
        return ""
    }

}

extension TicketCheckQRCodeViewController: ExitButtonDelegate {
    func exitButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
}
