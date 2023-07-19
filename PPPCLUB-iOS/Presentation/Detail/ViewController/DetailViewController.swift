//
//  DetailViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/08.
//

import UIKit

import SnapKit
import Then

final class DetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var spaceID = 1
    private var isFollowed: Bool = false
    private var hashTagList: [String] = [String]()
    private var recommandBookData: [DetailRecommendBookResult] = [] {
        didSet {
            detailView.ownerView.bookCollectionView.reloadData()
            self.moveCellToMiddle()
        }
    }
    private var currentIndex: Int = 0 {
        didSet {
            if !recommandBookData.isEmpty {
                self.detailView.ownerView.curationDataBind(curation:recommandBookData[self.currentIndex].comment)
                detailView.ownerView.curationTextView.text = recommandBookData[self.currentIndex].comment
                detailView.ownerView.bookNameLabel.text = recommandBookData[self.currentIndex].book.title
            }
        }
    }
    
    // MARK: - UI Components
    
    private let detailView = DetailView()
    
    // MARK: - Life Cycles
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        requestGetSpace()
        requestGetRecommendBook()
        requestGetFollow()
        requestSavedBookMarkAPI()
        requestGetCheckedArticle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
        register()
        delegate()
        
        style()
        hieararchy()
        layout()
    }
    
    
    // MARK: - Custom Method
    
    private func target() {
        detailView.detailTopView.saveButton.addTarget(self, action: #selector(didTouchedSaveButton), for: .touchUpInside)
        detailView.detailTopView.backButton.addTarget(self, action: #selector(didTouchedBackButton), for: .touchUpInside)
        detailView.articleRequestView.requestButton.addTarget(self, action: #selector(didTouchedRequestButton), for: .touchUpInside)
    }
    
    private func register() {
        detailView.detailTopView.tagCollectionView.register(DetailTagCollectionViewCell.self,
                                                            forCellWithReuseIdentifier: DetailTagCollectionViewCell.cellIdentifier)
        detailView.ownerView.bookCollectionView.register(DetailBookCollectionViewCell.self,
                                                         forCellWithReuseIdentifier: DetailBookCollectionViewCell.cellIdentifier)
    }
    
    private func delegate() {
        detailView.detailTopView.tagCollectionView.dataSource = self
        detailView.detailTopView.tagCollectionView.delegate = self
        detailView.ownerView.bookCollectionView.dataSource = self
        detailView.ownerView.bookCollectionView.delegate = self
    }
    
    private func style() {
        view.backgroundColor = .white
        detailView.do {
            $0.contentInsetAdjustmentBehavior = .never
        }
    }
    
    private func hieararchy() {
        view.addSubview(detailView)
    }
    
    private func layout() {
        detailView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(-1)
        }
    }
    
    private func addHashTag(list: [TagList]) {
        for index in 0..<list.count {
            hashTagList.append("# \(list[index].name)")
        }
    }
    
    private func isFollowAction() {
        detailView.articleRequestView.requestButton.isSelected = true
        detailView.articleRequestView.requestButton.backgroundColor = .pppMainPurple
    }
    
    private func moveCellToMiddle() {
        self.detailView.ownerView.bookCollectionView.isPagingEnabled = false
        self.detailView.ownerView.bookCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
//        self.detailView.ownerView.bookCollectionView.isPagingEnabled = true
    }
    
    private func checkCellIndex(index: Int) -> Int {
        if index < 0 {
            return 0
        } else if index > 2 {
            return 2
        }
        
        return index
    }
    
    // MARK: - Action Method
    
    @objc
    private func didTouchedSaveButton() {
        detailView.detailTopView.saveButton.isSelected.toggle()
        if detailView.detailTopView.saveButton.isSelected {
            requestPostSavedBookMarkAPI()
        } else {
            requestDeleteSavedBookMarkAPI()
        }
    }
    
    @objc func didTouchedRequestButton() {
        if !isFollowed {
            isFollowAction()
            requestPostFollow()
        }
    }
    
    @objc
    func didTouchedBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension DetailViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case detailView.detailTopView.tagCollectionView:
            return hashTagList.count
        case detailView.ownerView.bookCollectionView:
            return recommandBookData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case detailView.detailTopView.tagCollectionView:
            guard let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailTagCollectionViewCell.cellIdentifier,
                                                                   for: indexPath) as? DetailTagCollectionViewCell else { return UICollectionViewCell() }
            tagCell.configureCell(text: hashTagList[indexPath.row])
            tagCell.tagView.tagLabel.asColor(targetString: "#", color: .pppMainLightGreen)
            return tagCell
            
        case detailView.ownerView.bookCollectionView:
            guard let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailBookCollectionViewCell.cellIdentifier,
                                                                    for: indexPath) as? DetailBookCollectionViewCell else { return UICollectionViewCell() }
            bookCell.configureCell(recommendBookResult: recommandBookData[indexPath.row], isCenter: indexPath.row == currentIndex)

            return bookCell
            
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    //    func collectionView(_ collectionView: UICollectionView,
    //                        layout collectionViewLayout: UICollectionViewLayout,
    //                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        switch collectionView {
    //        case detailView.detailTopView.tagCollectionView:
    //            return 8
    //        case detailView.ownerView.bookCollectionView:
    //            return 32
    //        default:
    //            return 0
    //        }
    //    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case detailView.detailTopView.tagCollectionView:
            return 8
        case detailView.ownerView.bookCollectionView:
            return 32
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
            
        case detailView.detailTopView.tagCollectionView:
            let label: UILabel = UILabel()
            label.text = hashTagList[indexPath.row]
            return CGSize(width: Int(label.intrinsicContentSize.width) + 24 , height: 34)
            
        case detailView.ownerView.bookCollectionView:
            return CGSize(width: 116,
                          height: 156 )
            
        default:
            return CGSize()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = Const.itemSize.width + Const.itemSpacing
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left,
                                              y: scrollView.contentInset.top)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrolledOffset = scrollView.contentOffset.x + scrollView.contentInset.left
        let cellWidth = Const.itemSize.width + Const.itemSpacing
        let index = Int(round(scrolledOffset / cellWidth))
        currentIndex = checkCellIndex(index: index)
        detailView.ownerView.bookCollectionView.reloadData()
    }
}

// MARK: - DetailViewController

extension DetailViewController {
    private func requestSavedBookMarkAPI() {
        DetailAPI.shared.getSavedSpace(spaceID: "\(spaceID)") { result in
            guard let result = self.validateResult(result) as? DetailSavedBookMarkResult else { return }
            self.detailView.detailTopView.saveButton.isSelected = result.bookmarked!
        }
    }
    
    private func requestPostSavedBookMarkAPI() {
        DetailAPI.shared.postSavedSpace(spaceID: "\(spaceID)") { result in
            guard let result = self.validateResult(result) as? VoidResult else { return }
            print(result)
        }
    }
    
    private func requestDeleteSavedBookMarkAPI() {
        DetailAPI.shared.deleteSavedSpace(spaceID: "\(spaceID)") { result in
            guard let result = self.validateResult(result) as? VoidResult else { return }
            print(result)
        }
    }
    
    private func requestGetCheckedArticle() {
        DetailAPI.shared.getCheckArticle(spaceID: "\(spaceID)") { result in
            guard let result = self.validateResult(result) as? DetailCheckArticleResult else {
                self.detailView.isArticleExist = false
                return
            }
            self.detailView.isArticleExist = true
            self.detailView.moveToArticleView.dataBind(result: result)
        }
    }
    
    private func requestGetSpace() {
        DetailAPI.shared.getSpace(spaceID: "\(spaceID)") { result in
            guard let result = self.validateResult(result) as? DetailGetSpaceResult else { return }
            
            self.detailView.detailTopView.dataBind(name: result.name,
                                                   address: result.roadAddress,
                                                   runtime: result.operatingTime,
                                                   rest: result.closedDays,
                                                   imageURL: result.imageURL ?? String())
            self.addHashTag(list: result.tagList)
            self.detailView.ownerView.introDataBind(owner: result.owner,
                                                    introduce: result.introduction)
            self.detailView.detailTopView.tagCollectionView.reloadData()
        }
    }
    
    private func requestGetFollow() {
        DetailAPI.shared.getFollow(spaceID: "\(spaceID)") { result in
            guard let result = self.validateResult(result) as? DetailGetFollowResult else {
                print("😀😀😀😀")
                return
            }
            print(result)
            self.isFollowed = result.isFollowed ?? false
            print(self.isFollowed)
            if self.isFollowed {
                self.isFollowAction()
            }
        }
    }
    
    private func requestPostFollow() {
        DetailAPI.shared.postFollow(spaceID: "\(spaceID)") { result in
            guard let result = self.validateResult(result) as? VoidResult else { return }
            self.isFollowed = true
        }
    }
    
    private func requestGetRecommendBook() {
        DetailAPI.shared.getRecommendBool(spaceID: "\(spaceID)") { result in
            guard let result = self.validateResult(result) as? [DetailRecommendBookResult] else { return }
            self.recommandBookData = result
        }
    }
}
