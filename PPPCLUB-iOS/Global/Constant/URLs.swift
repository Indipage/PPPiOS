//
//  URLs.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import Foundation

public enum URLs{
    
    //MARK: - HOME
    
    static let weeklyArticle = "/article/weekly"
    static let patchSlideArticle = "/user/weekly/slide"
    static let totalArticle = "/article"
    static let detailArticle = "/article/{articleId}"
    
    //MARK: - Search
    
    static let getSpace = "/space/{spaceId}"
    static let getSearchSpace = "/space/list?keyword={}"
    
    //MARK: - Detail
    
    static let detailSpace = "/space/{spaceId}"
    static let getRecommendBook = "/space/{spaceId}/book"
    static let getFollow = "/space/{spaceId}/follow"
    static let postFollow = "/space/{spaceId}/follow"
    
    //MARK: - Ticket
    
    static let visitSpace = "/space/{spaceId}/visit"
    static let getTicket = "/user/ticket/{spaceId}"
    static let postTicket = "/user/ticket/{spaceId}"
    static let getTotalTicket = "/user/ticket"
    static let getTotalCard = "/user/card"
    
    //MARK: - MY
    
    static let getMyInfo = "/user"
    static let getTotalSavedArticle = "/user/bookmark/article"
    static let getSavedArticle = "/user/bookmark/article/{articleId}"
    static let postSavedArticle = "/user/bookmark/article/{articleId}"
    static let deleteSavedArticle = "/user/bookmark/article/{articleId}"
    static let getTotalSavedSpace = "/user/bookmark/space"
    static let getSavedSpace = "/user/bookmark/space/{spaceId}"
    static let postSavedSpace = "/user/bookmark/space/{spaceId}"
    static let deleteSavedSpace = "/user/bookmark/space/{spaceId}"
    
    
    
    
    
    
}
