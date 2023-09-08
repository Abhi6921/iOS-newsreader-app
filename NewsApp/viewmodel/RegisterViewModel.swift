//
//  RegisterViewModel.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 08/09/2023.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    func register(username: String, password: String, completion: @escaping (Bool) -> Void) {
        isLoading = true
        errorMessage = ""
        
        guard let url = URL(string: "https://inhollandbackend.azurewebsites.net/api/Users/register") else {
            isLoading = false
            errorMessage = "Invalid API URL"
            completion(false)
            return
        }
        
        let registerData = ["username": username, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: registerData)
            
        } catch {
            isLoading = false
            errorMessage = "Error encoding registeration data"
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                guard let httpResponse = response as? HTTPURLResponse, error == nil else {
                    self.errorMessage = "Network error"
                    completion(false)
                    return
                }
                
                let statusCode = httpResponse.statusCode
                
                if statusCode == 201 {
                    completion(true)
                } else {
                    self.errorMessage = "Registeration failed"
                    completion(false)
                }
            }
        }.resume()
    }
}
