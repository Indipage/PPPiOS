import UIKit

import SnapKit
import Then



class HomeArticleViewController: BaseViewController {
    
    // MARK: - Properties
    
    typealias ArticleBlockType = Dictionary<ArticleType,String>
    private var parsingData: [ArticleBlockType] = []
    
    private var bookmarkCheckData: HomeBookmarkCheckResult?
    
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
    
    
    var fullText: String? {
        didSet {
            articleDummy = fullText
            print("🤒🤒🤒🤒🤒🤒🤒🤒")
            print(articleDummy)
            print("🤒🤒🤒🤒🤒🤒🤒🤒")
            parsingData = HomeArticleParsing()
        }
    }
    var articleDummy:String?
    
    init(articleID: Int?) {
        self.articleID = articleID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    private let rootView = HomeArticleView()
    
    
    // MARK: - Life Cycles
    
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
    }
    
    //MARK: - Action Method
    
    @objc
    func backButtonTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func saveButtonTap() {
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
        
        print("😄Type: \(blockType), 😍Content: \(content)")
        
        switch blockType.first {
        case .title, .body:
            let tmpLabel = UILabel()
            tmpLabel.text = content.first
            tmpLabel.font = blockType.first?.font
            let cellWidth = 319.0
            let heightCnt = ceil((tmpLabel.intrinsicContentSize.width) / cellWidth)
            print("🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎")
            print("몇 번째: \(indexPath.row)")
            print("전체 가로 길이: \((round(tmpLabel.intrinsicContentSize.width) / cellWidth))")
            print("줄 개수 \(heightCnt)")
            print("세로 길이 \(heightCnt * tmpLabel.intrinsicContentSize.height)")
            print("🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎")
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
        footer.dataBindTicketCheck(articleData: ticketCheckData)
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
    func dataBind(articleData: HomeBookmarkCheckResult?) {
        guard let bookMarked = articleData?.bookmarked else { return }
        rootView.articleNavigationView.saveButton.isSelected = bookMarked
    }
    
    func dataBind(articleData: HomeTicketGetResult?) {
        guard let message = articleData?.message else { return }
    }
    
    func dataBind(articleData: HomeDetailArticleResult?) {
        guard let articleData = articleData else { return }
        self.articleID = articleData.id
        self.spaceID = articleData.spaceID
        self.fullText = articleData.content
        print("🤢🤢🤢🤢🤢🤢🤢🤢")
        print(self.articleDummy)
        print("🤢🤢🤢🤢🤢🤢🤢🤢")

    }
    
    func requestBookmarkCheckAPI() {
        guard let articleID = articleID else { return }
        HomeAPI.shared.getBookmarkCheck(articleID: "\(articleID)") { result in
            guard let result = self.validateResult(result) as? HomeBookmarkCheckResult else { return }
            self.bookmarkCheckData = result
            self.dataBind(articleData: self.bookmarkCheckData)
        }
    }
    
    public func requestBookmarkRegisterAPI() {
        guard let articleID = articleID else { return }
        HomeAPI.shared.postBookmarkCheck(articleID: "\(articleID)") { result in
            guard let result = self.validateResult(result) else { return }
        }
    }
    
    public func requestBookmarkDeleteAPI() {
        guard let articleID = articleID else { return }
        HomeAPI.shared.deleteBookmarkCheck(articleID: "\(articleID)") { result in
            guard let result = self.validateResult(result) else { return }
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
            self.dataBind(articleData: self.ticketGetData)
        }
    }
    
    public func requestDetailArticleAPI() {
        guard let articleID = articleID else { return }
        HomeAPI.shared.getDetailArticle(articleID: "\(articleID)") { result in
            guard let result = self.validateResult(result) as? HomeDetailArticleResult else { return }
            self.homeDetailArticleData = result
            self.dataBind(articleData: self.homeDetailArticleData)
        }
    }
    
    public func pushDetailViewController() {
        let detailViewController = DetailViewController()
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

































enum ArticleType: String {
    case title
    case body
    case img
    case hr
    
    var font: UIFont? {
        switch self {
        case .title:
            return .pppSubHead1
        case .body:
            return .pppBody5
        case .img:
            return nil
        case .hr:
            return nil
        }
    }
}






extension HomeArticleViewController {
    func blockCheck(text: String) -> ArticleType? {
        var articleType: ArticleType?
        guard let bodyStart = text.range(of: "<") else { return nil }
        guard let bodyEnd = text.range(of: ">") else { return nil}
        
        let startEnd = text[bodyStart].endIndex
        let endStart = text[bodyEnd].startIndex
        let endEnd = text[bodyEnd].endIndex
        
        let articleDummyEnd = text.endIndex
        let bodyChecked = text[startEnd ... endStart]
        
        var bodyTypeCheck = String(bodyChecked)
        bodyTypeCheck = bodyTypeCheck.trimmingCharacters(in: ["<", ">"])
        
        switch bodyTypeCheck {
        case ArticleType.body.rawValue:
            articleType = .body
        case ArticleType.title.rawValue:
            articleType = .title
        case ArticleType.img.rawValue:
            articleType = .img
        case ArticleType.hr.rawValue:
            articleType = .hr
        default:
            break
        }
        
        articleDummy = String(text[endEnd ..< articleDummyEnd])
        
        return articleType
    }
    
    func blockContentCheck(text:String, type: ArticleType?) -> (String)? {
        guard text.range(of: type?.rawValue ?? "") != nil else { return nil}
        let bodyEndRange = "<" + "/" + (type?.rawValue)! + ">"
        guard let bodyEnd = text.range(of: bodyEndRange) else { return nil }
        
        let endStart = text[bodyEnd].startIndex
        let endEnd = text[bodyEnd].endIndex
        let articleDummyEnd = text.endIndex
        
        let bodyChecked = text[text.startIndex ..< endStart]
        let bodyContentChecked =  String(bodyChecked)
        
        articleDummy = String(text[endEnd ..< articleDummyEnd])
        
        return (bodyContentChecked)
        
    }
    
    func HomeArticleParsing() -> [ArticleBlockType] {
        
        typealias ArticleBlockType = Dictionary<ArticleType,String>
        var parsingStored: [ArticleBlockType] = []
        
        while articleDummy!.count > 0 {
            
            var blockType : ArticleType?
            var blockContent : String?
            
            while blockType != .body {
                
                
                blockType = blockCheck(text: articleDummy!)
                blockContent = blockContentCheck(text: articleDummy!, type: blockType)
                if let blockType = blockType, let blockContent = blockContent {
                    let articleBlock: ArticleBlockType = [blockType: blockContent]
                    parsingStored.append(articleBlock)
                }
            }
        }
        return parsingStored
    }
    
}
