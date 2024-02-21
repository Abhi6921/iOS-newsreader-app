//
//  FavoritesView.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 09/09/2023.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var articleViewModel: ArticleViewModel
    
    var body: some View {
          
        NavigationView {
            Group {
                if articleViewModel.isLoadingfav {
                    ProgressView("Loading favorite Articles")
                } else {
                    VStack {
                        List {
                            ForEach(articleViewModel.favoritedArticles, id: \.id) { article in
                                NavigationLink(
                                    destination: ArticleDetailView(article: article, viewModel: articleViewModel, articleId: article.id)
                                ) {
                                    HStack(alignment: .center, spacing: 16) {
                                        // Article Image
                                        RemoteImage(url: article.image)
                                            .frame(width: 80, height: 80)
                                            .aspectRatio(contentMode: .fit)
                                        
                                        // Article Title
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(article.title)
                                                .font(.headline)
                                                .lineLimit(2)
                                            // Additional details if needed
                                        }
                                        
                                        Label("", systemImage: "heart.fill")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.red)
                                    }
                                }
                            }

                        }
                        .listStyle(PlainListStyle())
                        .navigationBarTitle("Favorites", displayMode: .inline)
                        
                    }
                    
                }
            }
            .onAppear {
                articleViewModel.fetchFavoritedArticles()
            }
            

        }
        .navigationBarHidden(true)
    }
}
    



struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}

    //                    VStack {
    //                        List {
    //                            ForEach(articleViewModel.favoritedArticles, id: \.id) { article in
    //                                NavigationLink(
    //                                    destination: ArticleDetailView(article: article)
    //                                ) {
    //                                    HStack(alignment: .center, spacing: 16) {
    //                                        // Article Image
    //                                        RemoteImage(url: article.image)
    //                                            .frame(width: 80, height: 80)
    //                                            .aspectRatio(contentMode: .fit)
    //
    //                                        // Article Title
    //                                        VStack(alignment: .leading, spacing: 8) {
    //                                            Text(article.title)
    //                                                .font(.headline)
    //                                                .lineLimit(2)
    //                                            // Additional details if needed
    //                                        }
    //                                        .padding(.vertical)
    //                                    }
    //                                    .padding(.horizontal)
    //                                }
    //                            }
    //                        }
    //                        .listStyle(PlainListStyle())
    //                        .navigationBarTitle("Article News", displayMode: .inline)
    //}
//            .onAppear {
//                articleViewModel.fetchFavoritedArticles()
//            }
