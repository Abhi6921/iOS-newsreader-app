//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 07/07/2023.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: NewsArticle
    var body: some View {
            VStack {
                RemoteImage(url: article.image)
                    .frame(width: 400, height: 300)
                    .aspectRatio(contentMode: .fit)
                VStack {
                    Text(article.title)
                        .font(.title)
                        .padding()
                    
                    Text(article.summary)
                        .font(.body)
                        .padding()
                    
                    Text(article.publishDate).font(.body)
                    Link("More Info here", destination: URL(string: article.url)!)
                                    .font(.headline)
                                    .padding()
                    
                    // Additional details and styling as needed
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleArticle = NewsArticle(id: 1, feed: 1, title: "Sample Title", summary: "Sample Summary", publishDate: "2022-01-01", image: "https://fastly.picsum.photos/id/682/200/300.jpg?hmac=z-Zlq9KVG3pNsE5Jo6A7vqnh-B910bdMztU5AZKQV-o", url: "https://example.com", related: [], categories: [], isLiked: false)
                
        ArticleDetailView(article: sampleArticle)
    }
}
