//
//  ArticleList.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 04/12/2022.
//

import Foundation

struct ArticleList: Codable {
    var results: [Article]
    var nextid: Int

    enum CodingKeys: String, CodingKey {
        case results = "Results"
        case nextid = "NextId"
    }
}






