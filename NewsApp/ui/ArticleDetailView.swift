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
                        .font(.system(size: 20))
                        .padding()
                    
                    Text(article.summary)
                        .font(.body)
                        .padding()
                    
                    if let formattedDate = formatDateString(article.publishDate) {
                        Text("Published Date: \(formattedDate)")
                            .padding()
                    }
                    Link("More Info here", destination: URL(string: article.url)!)
                                    .font(.headline)
                                    .padding()
                    
                    
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    
    func formatDateString(_ dateString: String) -> String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

            if let date = dateFormatter.date(from: dateString) {
                // Format the date into a human-readable string
                dateFormatter.dateFormat = "MMMM d, yyyy h:mm a"
                return dateFormatter.string(from: date)
            } else {
                return nil
            }
        }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleArticle = NewsArticle(id: 1, feed: 1, title: "Sample Title", summary: "Sample Summary", publishDate: "2022-01-01", image: "https://fastly.picsum.photos/id/682/200/300.jpg?hmac=z-Zlq9KVG3pNsE5Jo6A7vqnh-B910bdMztU5AZKQV-o", url: "https://example.com", related: [], categories: [], isLiked: false)
                
        ArticleDetailView(article: sampleArticle)
    }
}
