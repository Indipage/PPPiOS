//
//  TicketViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

import SnapKit
import Then

import RxSwift
import RxCocoa

final class TicketViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var viewModel: TicketViewModel
    private var animationManager: AnimationManager
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: TicketViewModel, animationManager: AnimationManager) {
        self.viewModel = viewModel
        self.animationManager = animationManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Components
    
    let rootView = TicketView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
        bindViewModel()
    }
    
    private func bindUI() {
        self.rx.viewWillAppear.subscribe(with: self, onNext: { owner, _ in
            owner.tabBarController?.tabBar.isHidden = false
        }).disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let input = TicketViewModel.Input(
            viewWillAppearEvent: self.rx.viewWillAppear.asObservable(),
            ticketToggleButtonDidTapEvent: rootView.ticketToggleView.ticketToggleButton.rx.tap.asObservable(),
            cardToggleButtonDidTapEvent: rootView.ticketToggleView.cardToggleButton.rx.tap.asObservable())
        
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
        
        output.displayMode
            .asDriver(onErrorJustReturn: .ticket)
            .drive(with: self, onNext: { owner, displayMode in
                owner.updateSelectedView(with: displayMode)
            }).disposed(by: disposeBag)
        
        output.toggleMode
            .asDriver(onErrorJustReturn: .ticket)
            .drive(with: self, onNext: { owner, toggleMode in
                owner.updateToggleView(toggleMode)
            }).disposed(by: disposeBag)
        
        output.ticketData
            .asDriver(onErrorJustReturn: [])
            .drive(
                self.rootView.ticketView.ticketCollectionView.rx.items(
                    cellIdentifier: TicketCollectionViewCell.cellIdentifier,
                    cellType: TicketCollectionViewCell.self)
            ) { index, data, cell in
                cell.configureCell(
                    ticket: data,
                    point: cell.center
                )
                cell.delegate = self
                self.updateSelectedView(with: self.viewModel.getDisplayMode())
            }.disposed(by: disposeBag)
        
        output.cardData
            .asDriver(onErrorJustReturn: [])
            .drive(
                self.rootView.cardView.ticketCardCollectionView.rx.items(
                    cellIdentifier: TicketCardCollectionViewCell.cellIdentifier,
                    cellType: TicketCardCollectionViewCell.self)
            ) { index, data, cell in
                self.rootView.cardView.cardImageView.kfSetImage(
                    url: data.imageURL
                )
                cell.configureCell(card: data)
                cell.delegate = self
                self.updateSelectedView(with: self.viewModel.getDisplayMode())
            }.disposed(by: disposeBag)
        
        self.rootView.ticketToggleView.ticketToggleButton.rx.tap.bind { [weak self] _ in
                     guard let self = self else { return }
                     let toggleView = self.rootView.ticketToggleView

                     self.animationManager.ticketToggleButtonAnimate (
                         targetView: toggleView.toggleButton,
                         translationX: self.viewModel.moveBy(),
                         selectedLabel: toggleView.ticketLabel,
                         unSelectedLable: toggleView.cardLabel
                     )
                     self.updateSelectedView(with: output.displayMode.value)
                 }.disposed(by: self.disposeBag)

                 self.rootView.ticketToggleView.cardToggleButton.rx.tap.bind { [weak self] _ in
                     guard let self = self else { return }
                     let toggleView = self.rootView.ticketToggleView

                     self.animationManager.ticketToggleButtonAnimate (
                         targetView: toggleView.toggleButton,
                         translationX: self.viewModel.moveBy(),
                         selectedLabel: toggleView.cardLabel,
                         unSelectedLable: toggleView.ticketLabel
                     )
                     self.updateSelectedView(with: output.displayMode.value)
                 }.disposed(by: self.disposeBag)

    }
}

//MARK: - TicketCardDelegate

extension TicketViewController: TicketCardDelegate {
    func cardImageButtonDidTap(image: UIImage?) {
        rootView.cardView.cardImageView.image = image
    }
}

//MARK: - TicketDelegate

extension TicketViewController: TicketDelegate {
    func ticketImageDidSwapped(spaceID: Int?) {
        pushToQRChecktView(spaceID: spaceID)
    }
}

//MARK: - TicketViewController

extension TicketViewController {
    private func updateSelectedView(with displayMode: DisplayMode) {
        switch displayMode {
        case .ticket:
            let isHidden = viewModel.getTicketData().isEmpty
            rootView.ticketView.isHidden = false
            rootView.cardView.isHidden = true
            rootView.ticketView.noTicketView.isHidden = !isHidden
            rootView.ticketView.ticketCollectionView.isHidden = isHidden
        case .card:
            let isHidden = viewModel.getCardData().isEmpty
            rootView.ticketView.isHidden = true
            rootView.cardView.isHidden = false
            rootView.cardView.noTicketCardView.isHidden = !isHidden
            rootView.cardView.ticketCardCollectionView.isHidden = isHidden
            rootView.cardView.cardImageView.isHidden = isHidden
        }
    }
    
    private func updateToggleView(_ displayMode: DisplayMode) {
        switch displayMode {
        case .ticket:
            break
        case .card:
            rootView.ticketToggleView.toggleButton.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.top.trailing.bottom.equalToSuperview().inset(3.adjusted)
                $0.width.equalTo(155.adjusted)
            }
        }
    }
    
    private func pushToQRChecktView(spaceID: Int?) {
        let qrcheckViewController = TicketCheckQRCodeViewController(spaceID: spaceID!)
        self.navigationController?.pushViewController(qrcheckViewController, animated: true)
    }
}
