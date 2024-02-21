//
//  NewsArticle.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 06/07/2023.
//

import Foundation

struct NewsArticle: Codable, Identifiable {
    let id: Int
    let feed: Int
    let title: String
    let summary: String
    let publishDate: String
    let image: String
    let url: String
    let related: [String]
    let categories: [Category]
    let isLiked: Bool
    
    struct Category: Codable, Hashable {
        let id: Int
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case id = "Id"
            case name = "Name"
        }
    }
    
    enum CodingKeys: String, CodingKey {
            case id = "Id"
            case feed = "Feed"
            case title = "Title"
            case summary = "Summary"
            case publishDate = "PublishDate"
            case image = "Image"
            case url = "Url"
            case related = "Related"
            case categories = "Categories"
            case isLiked = "IsLiked"
        }
}

enum APIError: Error {
    case missingAuthToken
    case invalidURL
    case noData
}

enum NetworkError: Error {
    case invalidURL
    case missingAuthToken
    case invalidResponse
    case noData
    // Add more error cases as needed
}
