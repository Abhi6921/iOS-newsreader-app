//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 29/10/2022.
//

import SwiftUI

@main
struct NewsAppApp: App {
    
    @StateObject private var loginModel = LoginViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loginModel)
                .environmentObject(ArticleViewModel())
            
        }
    }
}
