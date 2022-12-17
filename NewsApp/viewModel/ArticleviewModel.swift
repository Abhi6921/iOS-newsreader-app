//
//  NewsApi.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 04/12/2022.
//

import Foundation

class ArticleViewModel : ObservableObject {
    @Published var articles = [Article]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    init() {
        fetchAllArticles()
    }
    func fetchAllArticles() {
        isLoading = true
        let url = URL(string:"https://inhollandbackend.azurewebsites.net/api/Articles")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            self.isLoading = false
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            //decoder.dataDecodingStrategy = .secondsSince1970
            if let data = data {
                do{
                    let allArticles = try decoder.decode(ArticleList.self, from: data)
                    DispatchQueue.main.async {
                        let arc1 = allArticles.results
                            .map { article in
                                Article(
                                    id: article.id,
                                    feed: article.feed,
                                    title: article.title,
                                    summary: article.summary,
                                    publishDate: article.publishDate,
                                    image:article.image,
                                    url: article.url,
                                    isLiked: article.isLiked
                                )
                            }
                        self.articles = arc1
                    }
                    
                } catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
}
