//
//  LoginController.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 02/09/2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var isLoggedin = false
    @Published var showErrorPopup = false
    
    //func login(completion: @escaping (Bool) -> Void)
}
