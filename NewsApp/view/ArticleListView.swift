//
//  ArticleListView.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 29/10/2022.
//

import SwiftUI

struct ArticleListView: View {
    @StateObject var articleViewModel = ArticleViewModel()
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        //articleViewModel.articles
        ScrollView {
            if articleViewModel.isLoading {
                Spacer(minLength: 395)
                ProgressView("Loading")
            }
            
            LazyVStack(alignment: .leading,spacing: 5) {
                ForEach(articleViewModel.articles) { article in
                    ArticleCell(article: article)

                }
            }.navigationTitle("News")
            .onAppear(perform: {
                articleViewModel.fetchAllArticles()
            })
        }
        
        
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView()
    }
}
