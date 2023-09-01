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
    
    private let requestTotalTicket = PublishRelay<Void>()
    private let requestTotalCard =  PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    
    init(viewModel: TicketViewModel) {
        self.viewModel = viewModel
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
        
        bind()
        delegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        
        viewModel.getTotalTicket()
        viewModel.getTotalCard()
    }
    
    //MARK: - Custom Method
    
    private func delegate() {
        rootView.ticketView.ticketCollectionView.delegate = self
        rootView.ticketView.ticketCollectionView.dataSource = self
        
        rootView.cardView.ticketCardCollectionView.delegate = self
        rootView.cardView.ticketCardCollectionView.dataSource = self
    }
    
    private func bind() {
        let input = TicketViewModel.Input(
            ticketToggleButtonDidTapEvent: rootView.ticketToggleView.ticketToggleButton.rx.tap.asObservable(),
            cardToggleButtonDidTapEvent: rootView.ticketToggleView.cardToggleButton.rx.tap.asObservable(),
            requestGetTotalTicket: self.requestTotalTicket.asObservable(),
            requestGetTotalCard: self.requestTotalCard.asObservable()
        )
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
        
        updateSelectedView(with: output.displayMode.value)
        
        output.ticketData.asObservable().subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.rootView.ticketView.ticketCollectionView.reloadData()
        }).disposed(by: self.disposeBag)
        
        output.cardData.asObservable().subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            if !output.cardData.value.isEmpty {
                self.rootView.cardView.cardImageView.kfSetImage(url: output.cardData.value[0].imageURL)
            }
            self.rootView.cardView.ticketCardCollectionView.reloadData()
        }).disposed(by: self.disposeBag)
        
        self.rootView.ticketToggleView.ticketToggleButton.rx.tap.bind { [weak self] _ in
            guard let self = self else { return }
            let toggleView = self.rootView.ticketToggleView
            
            self.viewModel.getTotalTicket()
            
            AnimationManager.shared.ticketToggleButtonAnimate (
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
            
            self.viewModel.getTotalCard()
            
            AnimationManager.shared.ticketToggleButtonAnimate (
                targetView: toggleView.toggleButton,
                translationX: self.viewModel.moveBy(),
                selectedLabel: toggleView.cardLabel,
                unSelectedLable: toggleView.ticketLabel
            )
            self.updateSelectedView(with: output.displayMode.value)
        }.disposed(by: self.disposeBag)
    }
}

//MARK: - UICollectionViewDelegate

extension TicketViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case rootView.ticketView.ticketCollectionView:
            return CGSize(width: Size.width, height: 247.adjusted)
        case rootView.cardView.ticketCardCollectionView:
            return CGSize(width: 68.adjusted, height: 108.adjusted)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case rootView.ticketView.ticketCollectionView:
            return 25.adjusted
        case rootView.cardView.ticketCardCollectionView:
            return 15
        default:
            return 0
        }
    }
}

//MARK: - UICollectionViewDataSource

extension TicketViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case rootView.ticketView.ticketCollectionView:
            return viewModel.ticketData.value.count
        case rootView.cardView.ticketCardCollectionView:
            return viewModel.cardData.value.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case rootView.ticketView.ticketCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketCollectionViewCell.cellIdentifier, for: indexPath) as? TicketCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(ticket: viewModel.ticketData.value[indexPath.item], point: cell.center)
            cell.delegate = self
            return cell
        case rootView.cardView.ticketCardCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketCardCollectionViewCell.cellIdentifier, for: indexPath) as? TicketCardCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            cell.configureCell(card: viewModel.cardData.value[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
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
            let isHidden = viewModel.ticketData.value.isEmpty
            rootView.ticketView.isHidden = false
            rootView.cardView.isHidden = true
            rootView.ticketView.noTicketView.isHidden = !isHidden
            rootView.ticketView.ticketCollectionView.isHidden = isHidden
        case .card:
            let isHidden = viewModel.cardData.value.isEmpty
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
