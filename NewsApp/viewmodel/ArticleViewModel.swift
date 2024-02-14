//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 10/09/2023.
// https://inhollandbackend.azurewebsites.net/api/Articles

import Foundation

class ArticleViewModel: ObservableObject {
    @Published var newsArticles: [NewsArticle] = []
    @Published var isLoading: Bool = false
    @Published var favoritedArticles: [NewsArticle] = []
    @Published var isLoadingfav: Bool = false
    @Published var authToken: String?
    
    
    private var nextArticleId: Int?
    
    init() {
        AuthManager.shared.loadAuthToken()
    }
    
    func fetchAllNewsData() {
        isLoading = true
        guard let authentication_token = AuthManager.shared.getAuthToken() else {
            print("Authtoken is missing!")
            return
        }
        guard let url = URL(string: "https://inhollandbackend.azurewebsites.net/api/Articles") else {
            // Handle invalid URL
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(authentication_token, forHTTPHeaderField: "x-authtoken")
        print("authtoken from favorited function: \(authentication_token)")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error: \(error)")
                return
            }

            // Process the data received from the server
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(NewsResponse.self, from: data)

                    DispatchQueue.main.async {
                        self.newsArticles = response.Results
                        self.isLoading = false
                    }
                    
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                    
                    DispatchQueue.main.async {
                        self.isLoadingfav = false
                    }
                }
            }
        }.resume()
    }
    
    func fetchFavoritedArticles() {
        isLoadingfav = true
        guard let authentication_token = AuthManager.shared.getAuthToken() else {
            print("Authtoken is missing!")
            return
        }
        print("authtoken from favorites function: \(authentication_token)")
        
        guard let url = URL(string: "https://inhollandbackend.azurewebsites.net/api/Articles/liked") else {
            // Handle invalid URL
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(authentication_token, forHTTPHeaderField: "x-authtoken")
        print("authtoken from favorited function: \(authentication_token)")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Handle the response from the server
            if let error = error {
                print("Error: \(error)")
                // Handle the error
                return
            }

            // Process the data received from the server
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(NewsResponse.self, from: data)

                    DispatchQueue.main.async {
                        self.favoritedArticles = response.Results
                        self.isLoadingfav = false
                    }
                    
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                    
                    DispatchQueue.main.async {
                        self.isLoadingfav = false
                    }
                }
            }
        }.resume()
    }
}
