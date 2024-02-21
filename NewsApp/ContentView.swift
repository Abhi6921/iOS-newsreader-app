//
//  ContentView.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 29/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
                
        if (viewModel.isLoggedIn) {
            HomeView(viewModel: viewModel)
        }
        else {
            LoginView(viewModel: viewModel)
        }
    }
}
// TODO: Make the register user functionality work DONE
// TODO: add navigation bar DONE
// TODO: load the favorited articles by passing the authtoken key
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

