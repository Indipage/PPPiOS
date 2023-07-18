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
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
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
        cell.configureCell(article: parsingData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parsingData.count
    }
}

extension HomeArticleViewController {
    
    func HomeArticleParsing() -> [[String?]] {
        
        var parsingStored = [[String?]]()
        
        struct Body {
            var bold = [String]()
            var color = [String]()
            var click = [String]()
            var body = [String]()
        }
        
        var articleDummy = article
        
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
                
                func bodyCheck(text: String) -> String? {
                    
                    if let bodyStart = text.range(of: "<") {
                        if let bodyEnd = text.range(of: ">") {
                            
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
                        else { return nil }
                    }
                    else { return nil }
                }
                
                func bodyContentCheck(text:String, type:String) -> (String)? {
                    
                    if let bodyStart = text.range(of: type) {
                        let bodyEndRange = "<" + "/" + type + ">"
                        if let bodyEnd = text.range(of: bodyEndRange) {
                            
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
                        else { return nil }
                    }
                    else { return nil }
                }
            }
        }
        
        return parsingStored
    }
}

