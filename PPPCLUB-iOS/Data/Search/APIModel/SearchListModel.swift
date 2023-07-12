//
//  SearchListModel.swift
//  PPPCLUB-iOS
//
//  Created by 박윤빈 on 2023/07/12.
//

import UIKit

struct SearchListModel {
    let searchList: [SearchList]
}

struct SearchList {
    let image: UIImage
    let name: String
    let location: String
}

extension SearchListModel {
    static func dummy() -> SearchListModel {
        return SearchListModel(searchList: [SearchList(image: Image.mockBookStore,
                                                       name: "문학살롱 초고",
                                                       location: "서울특별시 영등포구 여의대로 108(여의도동, 파크원) 지하 2층"),
                                            SearchList(image: Image.mockBookStore,
                                                       name: "문학살롱 초고",
                                                       location: "서울특별시 영등포구 여의대로 108(여의도동, 파크원) 지하 2층"),
                                            SearchList(image: Image.mockBookStore,
                                                        name: "문학살롱 초고",
                                                        location: "서울특별시 영등포구 여의대로 108(여의도동, 파크원) 지하 2층"),
                                            SearchList(image: Image.mockBookStore,
                                                        name: "문학살롱 초고",
                                                        location: "서울특별시 영등포구 여의대로 108(여의도동, 파크원) 지하 2층"),
                                            SearchList(image: Image.mockBookStore,
                                                        name: "문학살롱 초고",
                                                        location: "서울특별시 영등포구 여의대로 108(여의도동, 파크원) 지하 2층"),
                                            SearchList(image: Image.mockBookStore,
                                                        name: "문학살롱 초고",
                                                        location: "서울특별시 영등포구 여의대로 108(여의도동, 파크원) 지하 2층"),
                                            SearchList(image: Image.mockBookStore,
                                                        name: "문학살롱 초고",
                                                        location: "서울특별시 영등포구 여의대로 108(여의도동, 파크원) 지하 2층"),
                                            SearchList(image: Image.mockBookStore,
                                                        name: "문학살롱 초고",
                                                        location: "서울특별시 영등포구 여의대로 108(여의도동, 파크원) 지하 2층"),
                                            SearchList(image: Image.mockBookStore,
                                                        name: "문학살롱 초고",
                                                        location: "서울특별시 영등포구 여의대로 108(여의도동, 파크원) 지하 2층"),
                                            SearchList(image: Image.mockBookStore,
                                                        name: "문학살롱 초고",
                                                        location: "서울특별시 영등포구 여의대로 108(여의도동, 파크원) 지하 2층"),
                                            SearchList(image: Image.mockBookStore,
                                                        name: "문학살롱 초고",
                                                        location: "서울특별시 영등포구 여의대로 108(여의도동, 파크원) 지하 2층"),
                                            SearchList(image: Image.mockBookStore,
                                                        name: "문학살롱 초고",
                                                        location: "서울특별시 영등포구 여의대로 108(여의도동, 파크원) 지하 2층"),
        ])
    }
}
