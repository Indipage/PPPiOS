import UIKit

import SnapKit
import Then


class HomeArticleViewController: BaseViewController {
    
    // MARK: - Properties
    
    typealias ArticleBlockType = Dictionary<ArticleType,String>
    private var parsingData: [ArticleBlockType] = []
    
    private var bookmarkCheckData: HomeBookmarkCheckResult? {
        didSet {
            self.dataBindBookmarkCheck(articleData: bookmarkCheckData)
        }
    }
    
    private var ticketCheckData: HomeTicketCheckResult? {
        didSet {
            rootView.articleTableView.reloadData()
        }
    }
    
    private var ticketGetData: HomeTicketGetResult? {
        didSet {
            self.dataBindTicketGet(articleData: ticketGetData)
        }
    }
    
    var articleDummy = article
    
    // MARK: - UI Components
    
    private let rootView = HomeArticleView()
    
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
        register()
        delegate()
        
        
        style()
        hierarchy()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        parsingData = HomeArticleParsing()
        requestBookmarkCheckAPI()
        requestTicketCheckAPI()
        for i in 0..<parsingData.count-1 {
            print("🤩🤩🤩🤩🤩🤩🤩🤩🤩")
            print(parsingData[i])
        }
    }
    
    // MARK: - Custom Method
    
    private func target() {
        
        rootView.articleNavigationView.articleBackButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        rootView.articleNavigationView.saveButton.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
        rootView.articleTableView.footerView.ticketButton.addTarget(self, action: #selector(ticketReceivedTap), for: .touchUpInside)
        
    }
    
    private func register() {
        
    }
    
    private func delegate() {
        
        rootView.articleTableView.delegate = self
        rootView.articleTableView.dataSource = self
    }
    
    private func style() {
    }
    
    private func hierarchy() {
    }
    
    private func layout() {
    }
    
    //MARK: - Action Method
    
    @objc
    func backButtonTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func articleDidTap() {
        let detailViewController = DetailViewController()
        self.navigationController?.pushViewController(detailViewController, animated: true)
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
    
    @objc
    func ticketReceivedTap() {
        rootView.articleTableView.footerView.ticketButton.kfSetButtonImage(url: rootView.articleTableView.footerView.ticketURL, state: .selected)
        rootView.articleTableView.footerView.ticketButton.isEnabled = false
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
            let cellWidth = 263.0
            let heightCnt = ceil((tmpLabel.intrinsicContentSize.width) / cellWidth)
            print("🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎")
            print("몇 번째: \(indexPath.row)")
            print("전체 가로 길이: \((ceil(tmpLabel.intrinsicContentSize.width) / cellWidth))")
            print("줄 개수 \(heightCnt)")
            print("세로 길이 \(heightCnt * tmpLabel.intrinsicContentSize.height)")
            print("🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎")
            return heightCnt * tmpLabel.intrinsicContentSize.height + (heightCnt - 1) * 9
        case .img:
            return 270
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeArticleHeaderView.cellIdentifier) as? HomeArticleHeaderView else { return UIView()}
        return header
    }
    
    internal func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 692
    }
    
    
    
    func tableView(_ tableView: UITableView, shouldScrollHorizontallyToItemAt section: Bool) -> Bool {
        return false
    }
}

extension HomeArticleViewController {
    func dataBindBookmarkCheck(articleData: HomeBookmarkCheckResult?) {
        guard let bookMarked = articleData?.bookmarked else { return }
        if bookMarked {
            rootView.articleNavigationView.saveButton.isSelected = true
        }
        else {
            rootView.articleNavigationView.saveButton.isSelected = false
        }
    }
    
    func dataBindTicketGet(articleData: HomeTicketGetResult?) {
        guard let message = articleData?.message else { return }
    }
    
    func requestBookmarkCheckAPI() {
        HomeAPI.shared.getBookmarkCheck(articleID: "1") { result in
            guard let result = self.validateResult(result) as? HomeBookmarkCheckResult else { return }
            self.bookmarkCheckData = result
        }
    }
    
    public func requestBookmarkRegisterAPI() {
        HomeAPI.shared.postBookmarkCheck(articleID: "1") { result in
            guard let result = self.validateResult(result) else { return }
        }
    }
    
    public func requestBookmarkDeleteAPI() {
        HomeAPI.shared.deleteBookmarkCheck(articleID: "1") { result in
            guard let result = self.validateResult(result) else { return }
        }
    }
    
    public func requestTicketCheckAPI() {
        HomeAPI.shared.getTicketCheck(spaceID: "1") { result in
            guard let result = self.validateResult(result) as? HomeTicketCheckResult else { return }
            self.ticketCheckData = result
        }
    }
    
    public func requestTicketGetAPI() {
        HomeAPI.shared.postTicketGet(spaceID: "1") { result in
            guard let result = self.validateResult(result) as? HomeTicketGetResult else { return }
            self.ticketGetData = result
        }
    }
}

//MARK: - UITableViewDataSource

extension HomeArticleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeArticleTableViewCell.cellIdentifier, for: indexPath) as? HomeArticleTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configureCell(article: parsingData[indexPath.row])
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

enum ArticleType: String {
    case title
    case body
    case img
    
    var font: UIFont? {
        switch self {
        case .title:
            return .pppSubHead1
        case .body:
            return .pppBody5
        case .img:
            return nil
        }
    }
}

extension HomeArticleViewController {
    func blockCheck(text: String) -> ArticleType? {
        var articleType: ArticleType?
        guard let bodyStart = text.range(of: "<") else { return nil }
        guard let bodyEnd = text.range(of: ">") else { return nil}
        
        let startStart = text[bodyStart].startIndex
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
        default:
            break
        }
        
        articleDummy = String(text[endEnd ..< articleDummyEnd])
        
        return articleType
    }
    
    func blockContentCheck(text:String, type: ArticleType?) -> (String)? {
        guard let bodyStart = text.range(of: type?.rawValue ?? "") else { return nil}
        let bodyEndRange = "<" + "/" + (type?.rawValue)! + ">"
        guard let bodyEnd = text.range(of: bodyEndRange) else { return nil }
        
        
        let startStart = text[bodyStart].startIndex
        let startEnd = text[bodyStart].endIndex
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
        
        //        var parsingStored = [[String?]]()
        
        while articleDummy.count > 0 {
            
            var blockType : ArticleType?
            var blockContent : String?
            
            while blockType != .body {
                
                
                blockType = blockCheck(text: articleDummy)
                blockContent = blockContentCheck(text: articleDummy, type: blockType)
                if let blockType = blockType, let blockContent = blockContent {
                    let articleBlock: ArticleBlockType = [blockType: blockContent]
                    parsingStored.append(articleBlock)
                }
                
                
                
            }
        }
        
        return parsingStored
    }
    
}
