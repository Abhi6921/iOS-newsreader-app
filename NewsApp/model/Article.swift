//
//  Article.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 29/10/2022.
//

import Foundation

struct Article: Codable, Identifiable {
    var id: Int
    var feed: Int
    var title: String
    var summary: String
    var publishDate: String
    var image: String
    var url: String
//    let related: [String]
//    let category: [Category]
    var isLiked: Bool
    
    enum CodingKeys: String, CodingKey {
            case id = "Id"
            case feed = "Feed"
            case title = "Title"
            case summary = "Summary"
            case publishDate = "PublishDate"
            case image = "Image"
            case url = "Url"
            case isLiked = "IsLiked"
        }
    static let testArticle: Article =
    Article(id: 123,
            feed: 456,
            title: "some cyclist is about to retrie",
            summary: "some summary",
            publishDate: "22/03/2022",
            image: "https://media.nu.nl/m/k3zx972ap9ap_sqr256.jpg/van-der-breggen-en-blaak-kondigen-afscheid-aan-als-wielrenster.jpg",
            url: "https://www.nu.nl/wielrennen/6050336/van-der-breggen-en-blaak-kondigen-afscheid-aan-als-wielrenster.html",
            isLiked: false
    )
}

struct Category: Codable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
    }
}




