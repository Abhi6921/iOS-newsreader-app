//
//  ArticleList.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 04/12/2022.
//

import Foundation

struct ArticleList: Codable {
    let results: [Results]
    let nextID: Int

    enum CodingKeys: String, CodingKey {
        case results = " Results "
        case nextID = " NextId "
    }
}


