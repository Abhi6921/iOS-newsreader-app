//
//  LoginView.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 02/09/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @ObservedObject var viewModel: LoginViewModel
    @State private var isDashboardActive = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

        var body: some View {
            NavigationView { 
                VStack {
                    Text("News App Login")
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
                    SecureField("Password", text: $password)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .padding()
                        .autocapitalization(.none)

                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 10)
                    
                    NavigationLink(
                        destination: HomeView(viewModel: viewModel),
                        isActive: $isDashboardActive,
                        label: {
                            EmptyView()
                        }
                    )
                    .opacity(0)

                    Button(action: {
                        viewModel.login(username: username, password: password) { success, authToken in
                            if success {
                                isDashboardActive = true
                                // Clear the text fields upon successful login
                                username = ""
                                password = ""
                                isLoggedIn = viewModel.isLoggedIn
                            }
                        }
                    }) {
                        Text("Login")
                            .font(.title)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
                    .padding(.top, 20)
                    .disabled(viewModel.isLoading)
                    
                    NavigationLink(
                    destination: RegisterView(viewModel: viewModel), // Specify your RegisterView here
                    label: {
                        Text("Register here")
                            .font(.headline)
                            .foregroundColor(.blue)
                    })
                    .padding(.top, 20)
                    
                    if viewModel.isLoading {
                        ProgressView("Logging in...")
                            .padding(.top, 10)
                    }
                }
                .padding()
                .navigationBarHidden(true) // Hide the navigation bar
            }
            .navigationBarHidden(true)
        }
//    struct LoginView_Previews: PreviewProvider {
//        static var previews: some View {
//            LoginView()
//        }
//    }
}
