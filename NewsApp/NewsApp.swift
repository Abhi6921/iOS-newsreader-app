//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 29/10/2022.
//

import SwiftUI

@main
struct NewsApp: App {
    
    @StateObject private var loginModel = LoginViewModel()
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some Scene {
        WindowGroup {            
            if isActive {
                ContentView()
                    .environmentObject(loginModel)
                    .environmentObject(ArticleViewModel())
            }
            else {
                VStack {
                    
                        VStack {
                            Image("app_icon_logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                            
                            Text("Gateway to Latest Headlines")
                                .font(Font.custom("Basterville-Bold", size: 30))
                                .foregroundColor(.purple)
                        }
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.2)) {
                                self.size = 0.9
                                self.opacity = 1.0
                            }
                        }
                    
                    
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        withAnimation {
                            self.isActive = true
                        }

                    }
                }
            }
        }
    }
}
