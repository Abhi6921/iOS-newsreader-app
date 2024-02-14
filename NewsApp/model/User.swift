//
//  User.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 02/09/2023.
//

import Foundation

struct User: Codable {
    
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username = "UserName"
        case password = "Password"
    }
    
}
