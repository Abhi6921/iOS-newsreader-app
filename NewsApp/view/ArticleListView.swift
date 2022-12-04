//
//  ArticleListView.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 29/10/2022.
//

import SwiftUI

struct ArticleListView: View {
    
    @EnvironmentObject var newsStore: NewsStore
    
    var body: some View {
//        List($newsStore.articles) { article in
//            ArticleCell(article: article)
//        }
//        .onAppear(perform: handleOnAppear)
        
        //Text("Hello World")
        List($newsStore.articles) { article in
            
        }
    }
}
private extension ArticleListView {
    func handleOnAppear() {
        newsStore.loadData()
    }
}
struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView().environmentObject(NewsStore())
    }
}
