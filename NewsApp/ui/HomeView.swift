//
//  BottomNavigationBarView.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 09/09/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: LoginViewModel
    var body: some View {
        TabView {
            ArticleListView(viewModel: viewModel)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
    
    

//    struct HomeView_Previews: PreviewProvider {
//        static var previews: some View {
//            HomeView()
//        }
//    }
}
