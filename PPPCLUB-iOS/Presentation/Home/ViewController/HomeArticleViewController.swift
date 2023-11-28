import UIKit

import SnapKit
import Then

final class HomeArticleViewController: BaseViewController {
    
    // MARK: - Properties
    
    typealias ArticleBlockType = Dictionary<ArticleType,String>
    private var parsingData: [ArticleBlockType] = [] {
        didSet {
            rootView.articleTableView.reloadData()
        }
    }
    
    private var bookmarkCheckData: HomeBookmarkCheckResult? {
        didSet {
            rootView.articleNavigationView.dataBind(articleData: bookmarkCheckData)
        }
    }
    
    private var ticketCheckData: HomeTicketCheckResult? {
        didSet {
            rootView.articleTableView.reloadData()
        }
    }
    
    private var ticketGetData: HomeTicketGetResult?
    private var homeDetailArticleData: HomeDetailArticleResult? {
        didSet {
            rootView.articleTableView.reloadData()
        }
    }
    
    private var articleID: Int?
    private var spaceID: Int? {
        didSet {
            requestTicketCheckAPI()
            requestTicketGetAPI()
        }
    }
    
    var fullText = "" {
        didSet {
            ArticleParsingManager.shared.articleDummy = fullText
            parsingData = ArticleParsingManager.shared.homeArticleParsing()
        }
    }
    
    // MARK: - UI Components
    private let rootView = HomeArticleView()
    
    // MARK: - Life Cycles
    
    init(articleID: Int?) {
        self.articleID = articleID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
        delegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        rootView.articleTableView.setContentOffset(CGPoint(x: 0, y: -rootView.articleTableView.contentInset.top), animated: true)
        requestBookmarkCheckAPI()
        requestDetailArticleAPI()
    }
    
    // MARK: - Custom Method
    
    private func target() {
        rootView.articleNavigationView.articleBackButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        rootView.articleNavigationView.saveButton.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
    }
    
    private func delegate() {
        rootView.articleTableView.delegate = self
        rootView.articleTableView.dataSource = self
//        toastView.delegate = self
    }
    
    //MARK: - Action Method
    
    @objc func backButtonTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButtonTap() {
        rootView.articleNavigationView.saveButton.isSelected.toggle()
        
        if rootView.articleNavigationView.saveButton.isSelected {
            requestBookmarkRegisterAPI()
        }
        else {
            requestBookmarkDeleteAPI()
        }
    }
    
}

//MARK: - UITableViewDelegate

extension HomeArticleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let blockType = parsingData[indexPath.row].keys
        let content = parsingData[indexPath.row].values
        
        //        print("😄Type: \(blockType), 😍Content: \(content)")
        
        switch blockType.first {
        case .title, .body:
            let tmpLabel = UILabel()
            tmpLabel.text = content.first
            tmpLabel.font = blockType.first?.font
            let cellWidth = 319.0
            let heightCnt = ceil((tmpLabel.intrinsicContentSize.width) / cellWidth)
            //            print("🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎")
            //            print("몇 번째: \(indexPath.row)")
            //            print("전체 가로 길이: \((round(tmpLabel.intrinsicContentSize.width) / cellWidth))")
            //            print("줄 개수 \(heightCnt)")
            //            print("세로 길이 \(heightCnt * tmpLabel.intrinsicContentSize.height)")
            //            print("🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎")
            return heightCnt * tmpLabel.intrinsicContentSize.height + (heightCnt - 1) * 9 + 30
        case .img:
            return 300
        case .hr:
            return 31
        case .none:
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeArticleHeaderView.cellIdentifier) as? HomeArticleHeaderView else { return UIView()}
        header.delegate = self
        header.dataBind(articleData: homeDetailArticleData)
        return header
    }
    
    internal func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 692
    }
    
    func tableView(_ tableView: UITableView, shouldScrollHorizontallyToItemAt section: Bool) -> Bool {
        return false
    }
}

//MARK: - UITableViewDataSource

extension HomeArticleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeArticleTableViewCell.cellIdentifier, for: indexPath) as? HomeArticleTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configureCell(article: parsingData[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parsingData.count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeArticleFooterView.cellIdentifier) as? HomeArticleFooterView else { return UIView()}
        footer.delegate = self
        footer.dataBindTicketCheck(articleData: ticketCheckData)
        footer.dataBindTicketCheck2(articleData: homeDetailArticleData)
        return footer
    }
    
}

extension HomeArticleViewController: TableViewCellDelegate {
    func pushDetailView() {
        pushDetailViewController()
    }
}

extension HomeArticleViewController: ArticleHeaderViewDelegate {
    func enterStoreButtonDidTap() {
        pushDetailViewController()
    }
}

extension HomeArticleViewController {
    func requestBookmarkCheckAPI() {
        guard let articleID = articleID else { return }
        HomeAPI.shared.getBookmarkCheck(articleID: "\(articleID)") { result in
            guard let result = self.validateResult(result) as? HomeBookmarkCheckResult else { return }
            self.bookmarkCheckData = result
        }
    }
    
    public func requestBookmarkRegisterAPI() {
        guard let articleID = articleID else { return }
        HomeAPI.shared.postBookmarkCheck(articleID: "\(articleID)") { result in
            guard self.validateResult(result) != nil else { return }
        }
    }
    
    public func requestBookmarkDeleteAPI() {
        guard let articleID = articleID else { return }
        HomeAPI.shared.deleteBookmarkCheck(articleID: "\(articleID)") { result in
            guard self.validateResult(result) != nil else { return }
        }
    }
    
    public func requestTicketCheckAPI() {
        guard let spaceID = spaceID else { return }
        HomeAPI.shared.getTicketCheck(spaceID: "\(spaceID)") { result in
            guard let result = self.validateResult(result) as? HomeTicketCheckResult else { return }
            self.ticketCheckData = result
        }
    }
    
    public func requestTicketGetAPI() {
        guard let spaceID = spaceID else { return }
        HomeAPI.shared.postTicketGet(spaceID: "\(spaceID)") { result in
            guard let result = self.validateResult(result) as? HomeTicketGetResult else { return }
            self.ticketGetData = result
        }
    }
    
    public func requestDetailArticleAPI() {
        guard let articleID = articleID else { return }
        HomeAPI.shared.getDetailArticle(articleID: "\(articleID)") { result in
            guard let result = self.validateResult(result) as? HomeDetailArticleResult else { return }
            self.homeDetailArticleData = result
            self.rootView.articleNavigationView.storeLabel.text = result.spaceName
            self.articleID = result.id
            self.spaceID = result.spaceID
            self.fullText = result.content
        }
    }
    
    public func pushDetailViewController() {
        let detailViewController = DetailViewController()
        detailViewController.dataBind(spaceID: spaceID)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension HomeArticleViewController : HomeArticleFooterViewDelegate {
    public func presentToastView() {
        
        DispatchQueue.main.async { [self] in
            let toastView = PPPToastMessage()
        
            self.view.addSubview(toastView)
            toastView.toastButton.addTarget(self, action: #selector(toastButtonTapped), for: .touchUpInside)
            
            toastView.snp.makeConstraints() {
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-46)
                $0.centerX.equalToSuperview()
                $0.leading.equalTo(28)
            }

            UIView.animate(withDuration: 1.0, delay: 4.0, options: .allowUserInteraction) {
                toastView.alpha = 0.0
            } completion: { _ in
                toastView.removeFromSuperview()
            }
        }
    }
    
    @objc
    private func toastButtonTapped() {
        print("💗")
        pushTicketViewController()
    }
    
    func pushTicketViewController() {
        print("💗⭐️")
        let ticketVC = TicketViewController(
            viewModel: TicketViewModel(
                ticketUseCase: DefaultTicketUseCase(
                    repository: DefaultTicketRepository()
                )
            ),
            animationManager: AnimationManager())
        
        self.navigationController?.pushViewController(ticketVC, animated: true)
    }
}
