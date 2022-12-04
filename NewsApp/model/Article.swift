//
//  Article.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 29/10/2022.
//

import Foundation

struct Results: Codable {
    let id, feed: Int
    let title, summary, publishDate, image: String
    let url: String
    let related: [String]
    let category: [Category]
    let isLike: Bool
    
    private enum ArticleResponseKeys
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case feed = "Feed"
        case title = "Title"
        case summary = "Summary"
        case publishDate = "PublishDate"
        case image = "Image"
        case url = "Url"
        case related = "Related"
        case category = "Category"
        case isLike = "IsLike"
    }
}

struct Category: Codable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
    }
}



