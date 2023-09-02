//
//  NewsResponse.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 06/07/2023.
//

import Foundation

struct NewsResponse: Codable {
    let NextId: Int
    let Results: [NewsArticle]
}
