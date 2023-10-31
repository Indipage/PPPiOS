//
//  OnboardingInfoCollectionViewCell.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 10/30/23.
//

import UIKit

import SnapKit
import Then

class OnboardingInfoCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    
    // MARK: - UI Components
    private var titleLabel = UILabel()
    private var contentLabel = UILabel()
    private var contentImageView = UIImageView()
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        hieararchy()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func style() {
        titleLabel.do {
            $0.font = .pppOnboarding3
            $0.textColor = .pppBlack
            $0.textAlignment = .center
        }
        
        contentLabel.do {
            $0.font = .pppOnboarding2
            $0.textColor = .pppBlack
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
    }
    
    private func hieararchy() {
        contentView.addSubviews(titleLabel, contentLabel, contentImageView)
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints() {
            $0.top.equalToSuperview().inset(125)
            $0.centerX.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints() {
            $0.top.equalTo(titleLabel.snp.bottom).offset(35)
            $0.centerX.equalToSuperview()
        }
    }
    
    func changeFont(changeText : String) {
        guard let text = contentLabel.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        let font = UIFont.pppOnboarding4
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: changeText))
        contentLabel.attributedText = attributeString
    }
    
    func changeFont2(changeText1 : String, changeText2 : String) {
        guard let text = contentLabel.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        let font = UIFont.pppOnboarding4
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: changeText1))
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: changeText2))
        contentLabel.attributedText = attributeString
    }
    
    func dataBind(tag: Int, _ data: OnboardingInfoModel) {
        self.tag = tag
        titleLabel.text = data.title
        contentLabel.text = data.contnet
        contentImageView.image = data.image
        
        
        switch tag {
        case 0:
            changeFont(changeText: "책방지기가 들려주는 서점 이야기")
            contentImageView.snp.makeConstraints() {
                $0.top.equalTo(contentLabel.snp.bottom).offset(26)
                $0.centerX.equalToSuperview()
            }
            
        case 1:
            changeFont(changeText: "티켓")
            contentImageView.snp.makeConstraints() {
                $0.top.equalTo(contentLabel.snp.bottom).offset(26)
                $0.centerX.equalToSuperview()
            }
            
        case 2:
            changeFont2(changeText1: "QR 인증", changeText2: "시그니처 카드")
            contentImageView.snp.makeConstraints() {
                $0.top.equalTo(contentLabel.snp.bottom).offset(100)
                $0.centerX.equalToSuperview()
            }
            
            var collection2 : UIImageView = {
                let image = UIImageView()
                image.image = Image.infoCollection2
                super.addSubview(image)
                image.snp.makeConstraints() {
                    $0.leading.equalToSuperview()
                    $0.centerY.equalTo(contentImageView.snp.centerY)
                }
                return image
            }()
            
            var collection3 : UIImageView = {
                let image = UIImageView()
                image.image = Image.infoCollection3
                super.addSubview(image)
                image.snp.makeConstraints() {
                    $0.trailing.equalToSuperview()
                    $0.centerY.equalTo(contentImageView.snp.centerY)
                }
                return image
            }()
            
        case 3:
            changeFont(changeText: "내 취향에 딱 맞는 공간")
            contentImageView.snp.makeConstraints() {
                $0.top.equalTo(contentLabel.snp.bottom).offset(100)
                $0.centerX.equalToSuperview()
            }
            
        case 4:
            contentImageView.snp.makeConstraints() {
                $0.top.equalTo(contentLabel.snp.bottom).offset(78)
                $0.centerX.equalToSuperview()
            }
            
        default:
            print("Cell Error")
        }
    }
}
