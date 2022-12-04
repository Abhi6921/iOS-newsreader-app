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
    
    private enum CodingKeys: String, CodingKey {
        case results = "Results"
        case nextID = "NextId"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([Results].self, forKey: .results)
        self.nextID = try container.decode(Int.self, forKey: .nextID)
    }
}




