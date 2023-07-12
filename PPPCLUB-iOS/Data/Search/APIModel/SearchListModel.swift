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
    static func dummy() -> [SearchList] {
        return [SearchList(image: Image.mockBookStore,
                           name: "문학살롱 초고",
                           location: "서울특별시 영등포구 여의대로 108(여의도동, 파크원) 지하 2층"),
                SearchList(image: Image.mockBookStore,
                           name: "문학살롱 초고",
                           location: "서울특별시 영등구 여의대로 108(여의도동, 파크원) 지하 2층"),
                SearchList(image: Image.mockBookStore,
                           name: "문학살롱 초고",
                           location: "서울특별시 영구 여의대로 108(여의도동, 파크원) 지하 2층"),
                SearchList(image: Image.mockBookStore,
                           name: "문학살롱 초고",
                           location: "서울특시 영등포구 여의대로 108(여의도동, 파크원) 지하 2층"),
                SearchList(image: Image.mockBookStore,
                           name: "문학살롱 초고",
                           location: "서울특별 등포구 여의대로 108(여의도동, 파크원) 지하 2층"),
                SearchList(image: Image.mockBookStore,
                           name: "문학살롱 초고",
                           location: "서울시 영포구 여의대로 108(여의도동, 파크원) 지하 2층"),
                SearchList(image: Image.mockBookStore,
                           name: "문학살롱 초고",
                           location: "서울특별시 포구 여의대로 108(여의도동, 파크원) 지하 2층"),
                SearchList(image: Image.mockBookStore,
                           name: "문학살롱 초고",
                           location: "서울특별시 구 여의대로 108(여의도동, 파크원) 지하 2층"),
                SearchList(image: Image.mockBookStore,
                           name: "문학살롱 초고",
                           location: "서울특별시 영등포구 여의대로 108(여의도동, 파크원) 지하 4층"),
                SearchList(image: Image.mockBookStore,
                           name: "문학살롱 초고",
                           location: "서울특별시 영등포구 여의대로 108(여의도동, 파크원) 지하 24층"),
                SearchList(image: Image.mockBookStore,
                           name: "문학살롱 초고",
                           location: "서울특별시 영등포구 여의대로 108(여의도동, 파크원) 지하 3층"),
                SearchList(image: Image.mockBookStore,
                           name: "문학살롱 초고",
                           location: "서울특별시 영등포구 여의대로 108(여의도동, 파크원) 지하 37층"),
        ]
    }
}
