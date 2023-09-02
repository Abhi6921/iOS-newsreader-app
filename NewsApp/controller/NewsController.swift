//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 29/10/2022.
//
import Foundation

class NewsController: ObservableObject {
    @Published var newsArticles: [NewsArticle] = []
    @Published var isLoading: Bool = false
    private var nextArticleId: Int?

    func fetchAllNewsData() {
        isLoading = true

        var urlString = "https://inhollandbackend.azurewebsites.net/api/Articles"
        var queryItems = [URLQueryItem]()

        // Set optional query parameters
        if let nextArticleId = nextArticleId {
            queryItems.append(URLQueryItem(name: "nextId", value: "\(nextArticleId)"))
        }
        // Add other optional parameters here if needed

        // Set default count parameter
        queryItems.append(URLQueryItem(name: "count", value: "20"))

        // Set query items in URL
        if !queryItems.isEmpty {
            var urlComponents = URLComponents(string: urlString)
            urlComponents?.queryItems = queryItems
            if let url = urlComponents?.url {
                urlString = url.absoluteString
            }
        }

        guard let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(NewsResponse.self, from: data)

                    DispatchQueue.main.async {
                        self.newsArticles += response.Results
                        self.nextArticleId = response.NextId
                        self.isLoading = false
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            }
        }.resume()
    }
}





