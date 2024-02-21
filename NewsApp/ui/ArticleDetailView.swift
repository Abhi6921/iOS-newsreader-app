//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 07/07/2023.
//

import SwiftUI
import Combine

struct ArticleDetailView: View {
    let article: NewsArticle
    @ObservedObject var viewModel: ArticleViewModel = ArticleViewModel()
    let articleId: Int
    @State private var isFavorite = false
    @State private var showToast = false
    
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.article) { article in
                    
                    RemoteImage(url: article.image)
                        .frame(width: 400, height: 400)
                        .padding(.top, 100)
                
                    VStack {
                        Text(article.title)
                            .font(.system(size: 20))
                            .padding()
                        
                        HStack {
                            Button(action: {
                                self.isFavorite.toggle()
                                self.showToast.toggle()
                                self.viewModel.toggleFavorite(articleId: article.id)
                            }) {
                                
                                Image(systemName: isFavorite ? "heart.fill" : "heart")
                                //.foregroundColor(isFavorite ? .yellow : .gray)
                                    .font(.system(size: 30))
                            }
                        }
                        Text(article.summary)
                            .font(.body)
                            .padding()
    
                        if let formattedDate = formatDateString(article.publishDate) {
                            Text("Published Date: \(formattedDate)")
                                .padding()
                        }
                        Link("Read More", destination: URL(string: article.url)!)
                            .font(.headline)
                            .padding()
                        
                        relatedSection(title: "related articles", items: article.related)
                        
                        articleCategories(title: "categories", items: article)
                        
                    }
                    .onAppear {
                        isFavorite = article.isLiked
                    }
                    .navigationBarItems(trailing: ShareLink(item: URL(string: article.url)!) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    })
                    
                }
            }
            .padding()
            .overlay(
                ToastView(message: isFavorite ? "Added to favorites" : "Removed from favorites", isShowing: $showToast)
                               .padding(.bottom, 470)
            )
            .onAppear {
                viewModel.getArticleById(articleId: articleId)
            }
            
            
        }
        .edgesIgnoringSafeArea(.top)
}
    
    func formatDateString(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"


        if let date = dateFormatter.date(from: dateString) {
            // Format the date into a human-readable string
            dateFormatter.dateFormat = "MMMM d, yyyy h:mm a"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    
}


private func relatedSection(title: String, items: [String]) -> some View {
    Group {
        if !items.isEmpty {
            VStack(alignment: .center) {
                Text(title)
                    .font(.headline)
                    .frame(alignment: .center)
                
                ForEach(items, id: \.self) { item in
                    VStack(alignment: .center) {
                        Divider()
                        Link(destination: URL(string: item)!) {
                            Text("View Article")
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(Color.purple)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }
}

private func articleCategories(title: String, items: NewsArticle) -> some View {
    Group {
        if !items.categories.isEmpty {
            VStack(alignment: .center) {
                Text(title)
                    .font(.headline)
                    .frame(alignment: .center)

                ForEach(items.categories, id: \.self) { item in
                    VStack(alignment: .center) {
                        Divider()
                        //Link(destination: URL(string: item.name)!) {
                        Text(item.name)
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(Color.blue)
                        //}
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }
}


//struct ArticleDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        let sampleArticle = NewsArticle(id: 1, feed: 1, title: "Sample Title", summary: "Sample Summary", publishDate: "2022-01-01", image: "https://fastly.picsum.photos/id/682/200/300.jpg?hmac=z-Zlq9KVG3pNsE5Jo6A7vqnh-B910bdMztU5AZKQV-o", url: "https://example.com", related: [], categories: [], isLiked: false)
//
//        ArticleDetailView(article: sampleArticle)
//    }
//}
