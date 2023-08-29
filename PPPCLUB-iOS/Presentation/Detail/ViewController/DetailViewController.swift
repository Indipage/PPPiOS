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
    
    private var spaceID: Int?
    private var articleID: Int?
    private var isFollowed: Bool = false
    private var isTouched: Bool = false
    private var hashTagList: [String] = [String]()
    private var totalCellWidth: Int = 0
    private var recommandBookData: [DetailRecommendBookResult] = [] {
        didSet {
            detailView.ownerView.bookCollectionView.reloadData()
            if !recommandBookData.isEmpty {
                self.moveCellToCurrentIndex(index: 1)
            } else {
                presentBottomAlert("추천서가가 비어있습니다!")
            }
        }
    }
    private var currentIndex: Int = 1 {
        didSet {
            if !recommandBookData.isEmpty {
                self.detailView.ownerView.curationDataBind(curation: recommandBookData[self.currentIndex].comment)
                self.detailView.curationDataBind(curation: recommandBookData[self.currentIndex].comment)
                detailView.ownerView.curationTextView.text = recommandBookData[self.currentIndex].comment
                detailView.ownerView.bookNameLabel.text = recommandBookData[self.currentIndex].book.title
                print("\(detailView.ownerView.bookNameLabel.text)")
            }
        }
    }
    
    // MARK: - UI Components
    
    private let detailView = DetailView()
    
    // MARK: - Life Cycles
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        requestGetRecommendBook()
        requestGetSpace()
        requestGetFollow()
        requestSavedBookMarkAPI()
        requestGetCheckedArticle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gesture()
        target()
        register()
        delegate()
        
        style()
        hieararchy()
        layout()
    }
    
    
    // MARK: - Custom Method
    
    private func gesture() {
        lazy var moveToArticleViewGesture = UITapGestureRecognizer.init(target: self, action: #selector(moveToArticleViewGestureHandler))
        
        detailView.moveToArticleView .addGestureRecognizer(moveToArticleViewGesture)
    }
    
    private func target() {
        detailView.detailTopView.saveButton.addTarget(self, action: #selector(didTouchedSaveButton), for: .touchUpInside)
        detailView.detailTopView.backButton.addTarget(self, action: #selector(didTouchedBackButton), for: .touchUpInside)
        detailView.articleRequestView.requestButton.addTarget(self, action: #selector(didTouchedRequestButton), for: .touchUpInside)
        detailView.moveToArticleView.contentButton.addTarget(self, action: #selector(moveToArticleViewDidTap), for: .touchUpInside)
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
        let label = UILabel()
        for index in 0..<list.count {
            hashTagList.append("# \(list[index].name)")
            label.text = "# \(list[index].name)"
            totalCellWidth = totalCellWidth + Int(label.intrinsicContentSize.width) + 40
        }
            totalCellWidth = totalCellWidth - 20
    }
    
    private func isFollowAction() {
        detailView.articleRequestView.requestButton.isSelected = true
        detailView.articleRequestView.requestButton.backgroundColor = .pppMainPurple
    }
    
    private func moveCellToCurrentIndex(index: Int) {
        self.detailView.ownerView.bookCollectionView.isPagingEnabled = false
        self.detailView.ownerView.bookCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
        self.detailView.ownerView.bookCollectionView.isPagingEnabled = true
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
    
    @objc private func didTouchedSaveButton() {
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
    
    @objc func didTouchedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func moveToArticleViewDidTap() {
        print("Move to article view tapped!")
        let articleViewController = HomeArticleViewController(articleID: articleID)
        self.navigationController?.pushViewController(articleViewController, animated: true)
    }
    
    @objc func moveToArticleViewGestureHandler() {
        print("Move to article view tapped!")
        let articleViewController = HomeArticleViewController(articleID: articleID)
        self.navigationController?.pushViewController(articleViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isTouched = true
        currentIndex = indexPath.item
        self.moveCellToCurrentIndex(index: currentIndex)
    }
}

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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacing section: Int) -> CGFloat {
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
        if !isTouched {
            currentIndex = checkCellIndex(index: index)
        }
        detailView.ownerView.bookCollectionView.reloadData()
    }
    
    /// 터치시 스크롤 되면, scrollViewDidScroll이 실행되면서
    /// currentIndex가 다시 이전 인덱스로 변화하게 된다.
    /// 따라서 isTouched라는 변수를 만들고,
    /// 스크롤이 끝났을 때 false로 변화시켜줌으로써 문제 해결!

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        isTouched = false
    }
}

// MARK: - DetailViewController

extension DetailViewController {
    private func requestSavedBookMarkAPI() {
        guard let spaceID = spaceID else { return }
        DetailAPI.shared.getSavedSpace(spaceID: "\(spaceID)") { result in
            guard let result = self.validateResult(result) as? DetailSavedBookMarkResult else { return }
            self.detailView.detailTopView.saveButton.isSelected = result.bookmarked!
        }
    }
    
    private func requestPostSavedBookMarkAPI() {
        guard let spaceID = spaceID else { return }
        DetailAPI.shared.postSavedSpace(spaceID: "\(spaceID)") { result in
            guard let result = self.validateResult(result) as? VoidResult else { return }
            print(result)
        }
    }
    
    private func requestDeleteSavedBookMarkAPI() {
        guard let spaceID = spaceID else { return }
        DetailAPI.shared.deleteSavedSpace(spaceID: "\(spaceID)") { result in
            guard let result = self.validateResult(result) as? VoidResult else { return }
            print(result)
        }
    }
    
    private func requestGetCheckedArticle() {
        guard let spaceID = spaceID else { return }
        DetailAPI.shared.getCheckArticle(spaceID: "\(spaceID)") { result in
            guard let result = self.validateResult(result) as? DetailCheckArticleResult else {
                self.detailView.isArticleExist = false
                return
            }
            self.detailView.isArticleExist = true
            self.articleID = result.id
            self.detailView.moveToArticleView.dataBind(result: result)
        }
    }
    
    private func requestGetSpace() {
        guard let spaceID = spaceID else { return }
        DetailAPI.shared.getSpace(spaceID: "\(spaceID)") { result in
            guard let result = self.validateResult(result) as? DetailGetSpaceResult else { return }
            
            self.detailView.detailTopView.dataBind(name: result.name,
                                                   address: result.roadAddress,
                                                   runtime: result.operatingTime ?? "정보 없음",
                                                   rest: result.closedDays ?? "",
                                                   imageURL: result.imageURL ?? String())
            self.addHashTag(list: result.tagList)
            self.detailView.uniqueView.dataBind(title: result.peculiarityTitle ?? "",
                                                content: result.peculiarityContent ?? "",
                                                image: result.peculiarityImageURL ?? String()
            )
            self.detailView.introDataBind(introduce: result.introduction ?? "")
            self.detailView.ownerView.introDataBind(owner: result.owner ?? "",
                                                    introduce: result.introduction ?? "")
            self.detailView.detailTopView.calcCollectionViewWidth(width: self.totalCellWidth)
            self.detailView.detailTopView.tagCollectionView.reloadData()
        }
    }
    
    private func requestGetFollow() {
        guard let spaceID = spaceID else { return }
        DetailAPI.shared.getFollow(spaceID: "\(spaceID)") { result in
            guard let result = self.validateResult(result) as? DetailGetFollowResult else {
                print("😀😀😀😀")
                return
            }
            print(result)
            self.isFollowed = result.isFollowed ?? false
            if self.isFollowed {
                self.isFollowAction()
            }
        }
    }
    
    private func requestPostFollow() {
        guard let spaceID = spaceID else { return }
        DetailAPI.shared.postFollow(spaceID: "\(spaceID)") { result in
            guard self.validateResult(result) is VoidResult else { return }
            self.isFollowed = true
        }
    }
    
    private func requestGetRecommendBook() {
        guard let spaceID = spaceID else { return }
        DetailAPI.shared.getRecommendBool(spaceID: "\(spaceID)") { result in
            guard let result = self.validateResult(result) as? [DetailRecommendBookResult] else { return }
            self.recommandBookData = result
        }
    }
    
    func dataBind(spaceID: Int?) {
        print("여기로 들어온 spaceID는 \(spaceID)")
        self.spaceID = spaceID
    }
}
