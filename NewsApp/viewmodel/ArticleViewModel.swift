//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 10/09/2023.
// https://inhollandbackend.azurewebsites.net/api/Articles
// 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
import Foundation

class ArticleViewModel: ObservableObject {
    @Published var newsArticles: [NewsArticle] = []
    @Published var isLoading: Bool = false
    @Published var favoritedArticles: [NewsArticle] = []
    @Published var isLoadingfav: Bool = false
    @Published var isArticleDetailLoading: Bool = false
    @Published var authToken: String?
    @Published var isFavorite = false
    @Published var article: [NewsArticle] = []
    private var nextArticleId: Int?
    
    init() {
        AuthManager.shared.loadAuthToken()
    }
    
    func toggleFavorite(articleId: Int) {
        if isFavorite {
            removeFromFavorites(articleId: articleId)
        }
        else {
            addToFavorites(articleId: articleId)
        }
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
        print("authtoken from all articles function: \(authentication_token)")
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
    
    func getArticleById(articleId: Int) {
        
        isArticleDetailLoading = true
        guard let authenticationToken = AuthManager.shared.getAuthToken() else {
            print("Auth token is missing!")
            return
        }
        
        guard let url = URL(string: "https://inhollandbackend.azurewebsites.net/api/Articles/\(articleId)") else {
                print("Invalid URL")
                return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(authenticationToken, forHTTPHeaderField: "x-authtoken")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                
                return
            }
            
            guard let data = data else {
                print("No data received")
                let error = NSError(domain: "", code: -1, userInfo: nil)
                
                return
            }
            
            do {
               let decoder = JSONDecoder()
               decoder.keyDecodingStrategy = .convertFromSnakeCase
               let response = try decoder.decode(NewsResponse.self, from: data)
               DispatchQueue.main.async {
                   self.article = response.Results
                   self.isArticleDetailLoading = false
                   
               }
           } catch {
               print("Error decoding JSON: \(error)")
               DispatchQueue.main.async {
                   self.isArticleDetailLoading = false
                   
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
        //print("authtoken from favorited function: \(authentication_token)")
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
    
    
    private func addToFavorites(articleId: Int) {
        guard let authentication_token = AuthManager.shared.getAuthToken() else {
            print("Authtoken is missing!")
            return
        }
        
        guard let url = URL(string: "https://inhollandbackend.azurewebsites.net/api/Articles/\(articleId)/like") else {
            // Handle invalid URL
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue(authentication_token, forHTTPHeaderField: "x-authtoken")
        print("authtoken from addToFavorites function: \(authentication_token)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            
                if httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        self.isFavorite = true
                    }
                } else {
                    print("Failed to add article to favorites. Status code: \(httpResponse.statusCode)")
                }
            }
        }.resume()
    }
    
    private func removeFromFavorites(articleId: Int) {
        guard let authentication_token = AuthManager.shared.getAuthToken() else {
            print("Authtoken is missing!")
            return
        }
        
        guard let url = URL(string: "https://inhollandbackend.azurewebsites.net/api/Articles/\(articleId)/like") else {
            // Handle invalid URL
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue(authentication_token, forHTTPHeaderField: "x-authtoken")
        print("authtoken from removeFromFavorites function: \(authentication_token)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            
                if httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        self.isFavorite = false
                    }
                } else {
                    print("Failed to remove article to favorites. Status code: \(httpResponse.statusCode)")
                    
                }
            }
        }.resume()
    }
}
