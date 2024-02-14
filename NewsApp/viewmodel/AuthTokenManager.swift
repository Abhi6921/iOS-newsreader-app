//
//  AuthTokenManager.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 10/02/2024.
//

import Foundation
import Security

class AuthManager {
    
    static let shared = AuthManager()
    
    private let authTokenKey = "AuthToken"
    
    
        
    private init() {
        // Load authToken from UserDefaults when AuthManager is initialized
        self.authToken = UserDefaults.standard.string(forKey: authTokenKey)
    }
    
    private var authToken: String? {
        didSet {
            // Save authToken to UserDefaults when it's set
            UserDefaults.standard.set(authToken, forKey: authTokenKey)
        }
    }
    
   
    
    func setAuthToken(token: String) {
        self.authToken = token
    }
    
    func getAuthToken() -> String? {
        return self.authToken
    }
    
    func removeAuthToken() {
        self.authToken = nil
    }
    
    func loadAuthToken() -> String? {
        return self.authToken
    }
    
}


