//
//  LoginViewModel.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 03/09/2023.
//
// https://inhollandbackend.azurewebsites.net/api/Users/login


import Foundation

class LoginViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        }
    }
    
     
    init() {
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
    }
    
    func login(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        isLoading = true
        errorMessage = ""
        
        guard let url = URL(string: "https://inhollandbackend.azurewebsites.net/api/Users/login") else {
            isLoading = false
            errorMessage = "Invalid API URL"
            completion(false, nil)
            return
        }
        
        let loginData = ["UserName": username, "Password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: loginData)
        } catch {
            isLoading = false
            errorMessage = "Error encoding login data"
            completion(false, nil)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                guard let data = data, error == nil else {
                    self.errorMessage = "Network error: \(error?.localizedDescription ?? "Unknown error")"
                    completion(false, nil)
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        if let authToken = json["AuthToken"] as? String {
                            print("AuthToken is: \(authToken)")
                            self.isLoggedIn = true
                            AuthManager.shared.setAuthToken(token: authToken)
                            completion(true, authToken)
                        } else {
                            self.errorMessage = "Authentication token missing in response"
                            completion(false, nil)
                        }
                    } else {
                        self.errorMessage = "Invalid JSON response"
                        completion(false, nil)
                    }
                } catch {
                    self.errorMessage = "Invalid username or password! please try again"
                    completion(false, nil)
                }
            }
        }.resume()
    }

    func logout() {
        isLoggedIn = false
        AuthManager.shared.removeAuthToken()
    }
}
