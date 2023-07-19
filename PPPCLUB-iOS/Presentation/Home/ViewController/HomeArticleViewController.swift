//
//  HomeArticleViewController.swift
//  PPPCLUB-iOS
//
//  Created by 신지원 on 2023/07/12.
//

import UIKit

import SnapKit
import Then


class HomeArticleViewController: UIViewController {
    
    // MARK: - Properties
    
    private var parsingData = [[String?]]()
    private var parsingCnt = Int()
    
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
        parsingCnt = parsingData.count/2
    }
    
    // MARK: - Custom Method
    
    private func target() {
        
        rootView.articleNavigationView.articleBackButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
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
    
}

//MARK: - UITableViewDelegate

extension HomeArticleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let blockType = parsingData[indexPath.row][0] else { return 0 }
        guard let content = parsingData[indexPath.row][1] else { return 0 }
        switch blockType {
        case "title":
            let tmpLabel = UILabel()
            tmpLabel.text = content
            tmpLabel.font = .pppSubHead1
            let cellWidth = 263.0
            let heightCnt = ceil((tmpLabel.intrinsicContentSize.width) / cellWidth)
            print("🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎")
            print("몇 번째: \(indexPath.row)")
            print("전체 가로 길이: \((ceil(tmpLabel.intrinsicContentSize.width) / cellWidth))")
            print("줄 개수 \(heightCnt)")
            print("세로 길이 \(heightCnt * tmpLabel.intrinsicContentSize.height)")
            print("🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎")
            return heightCnt * tmpLabel.intrinsicContentSize.height
        case "body":
            let tmpLabel = UILabel()
            tmpLabel.text = content
            tmpLabel.font = .pppBody5
            let cellWidth = 263.0
            let heightCnt = ceil((tmpLabel.intrinsicContentSize.width) / cellWidth)
            print("🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎")
            print("몇 번째: \(indexPath.row)")
            print("전체 가로 길이: \((ceil(tmpLabel.intrinsicContentSize.width) / cellWidth))")
            print("줄 개수 \(heightCnt)")
            print("세로 길이 \(heightCnt * tmpLabel.intrinsicContentSize.height)")
            print("🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎🦎")
            return heightCnt * tmpLabel.intrinsicContentSize.height + 35
        case "img":
            return 270
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeArticleHeaderView.cellIdentifier) as? HomeArticleHeaderView else { return UIView()}
        return header
    }
    
    private func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> Int {
        return 692
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeArticleFooterView.cellIdentifier) as? HomeArticleFooterView else { return UIView()}
        return footer
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
        print("🦖🦖🦖🦖🦖🦖🦖🦖🦖🦖🦖")
        
        print("type: \(parsingData[indexPath.row][0]) , content: \(parsingData[indexPath.row][1])")
        print("🦖🦖🦖🦖🦖🦖🦖🦖🦖🦖🦖")
        cell.configureCell(article: parsingData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parsingData.count
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
    func bodyCheck(text: String) -> String? {
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
        
        articleDummy = String(text[endEnd ..< articleDummyEnd])
        
        return (bodyTypeCheck)
        
    }
    
    func bodyContentCheck(text:String, type:String) -> (String)? {
        guard let bodyStart = text.range(of: type) else { return nil}
        let bodyEndRange = "<" + "/" + type + ">"
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
    
    
    
    
    func HomeArticleParsing() -> [[String?]] {
        
        typealias ArticleBlockType = Dictionary<ArticleType,String>
        //        var parsingStored: [ArticleBlockType] = []
        
        var parsingStored = [[String?]]()
        
        struct Body {
            var bold = [String]()
            var color = [String]()
            var click = [String]()
            var body = [String]()
        }
        
        
        
        while articleDummy.count > 0 {
            
            var blockType : String?
            var blockContent : String?
            
            while blockType != "body" {
                
                var ArticleBody : Body = Body()
                
                blockType = bodyCheck(text: articleDummy)
                blockContent = bodyContentCheck(text: articleDummy, type: blockType ?? "")
                
                switch blockType {
                case "title":
                    parsingStored.append(["title", blockContent])
                case "img":
                    parsingStored.append(["img", blockContent])
                case "body":
                    parsingStored.append(["body", blockContent])
                default:
                    blockType = ""
                }
                
                
                
                
            }
        }
        
        return parsingStored
    }
    
}
