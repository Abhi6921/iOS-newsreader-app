//
//  RegisterView.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 02/09/2023.
//

import SwiftUI

struct RegisterView: View {
    @State private var username = ""
    @State private var password = ""
    @StateObject private var registerViewModel = RegisterViewModel()
    @State private var isDashboardActive = false
    @State private var isRegisterationSuccessful = false
    
    var body: some View {
        NavigationView { // Wrap your view in a NavigationView
            VStack {
                Text("News App Register")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.black)
                    .padding()
                
                TextField("Username", text: $username)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .padding()
                    .autocapitalization(.none)
                
                Spacer().frame(height: 5)
                TextField("Password", text: $password)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .padding()
                    .autocapitalization(.none)
                
                Text(registerViewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 10)
                
                NavigationLink(
                    destination: ArticleListView(),
                    isActive: $isDashboardActive,
                    label: {
                        EmptyView()
                    }
                )
                .opacity(0)
                
                Button(action: {
                    registerViewModel.register(username: username, password: password) { success in
                        if success {
                            isRegisterationSuccessful = true
                        }
                    }
                }) {
                    Text("Register User")
                        .font(.title)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 20)
                .disabled(registerViewModel.isLoading)
                
                Text(registerViewModel.errorMessage)
                .foregroundColor(.red)
                .padding(.top, 10)
                
                NavigationLink(
                    destination: LoginView(), // Specify your RegisterView here
                    label: {
                        Text("Login Here")
                            .font(.headline)
                            .foregroundColor(.blue)
                    })
                    .padding(.top, 20)
            }
            .padding()
            .navigationBarHidden(true) // Hide the navigation bar
            
            if registerViewModel.isLoading {
                ProgressView("Registering...")
                .padding(.top, 10)
            }
            
            
        }
        .navigationBarHidden(true)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
