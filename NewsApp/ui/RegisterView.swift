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
    @State private var isRegistering = false
    
    var body: some View {
            NavigationView {
                VStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding()

                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)

                    Button(action: {
                        // Perform login logic here
                        self.register()
                    }) {
                        Text("Register User")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                    Spacer()
                }
                .padding()
                .navigationTitle("News App Register")
                .navigationBarBackButtonHidden(true)
            }
        }

        func register() {
            // You can implement your own login logic here
            // For this example, we'll simply consider the user as logged in if both
        }
    }

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
