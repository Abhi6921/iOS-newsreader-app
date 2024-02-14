//
//  ArticleListView.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 06/07/2023.
//

import SwiftUI

struct ArticleListView: View {
    @ObservedObject var viewModel: LoginViewModel
    @EnvironmentObject var newsController: ArticleViewModel
    @Environment(\.presentationMode) var presentationMode // Add this environment variable

    
    @State private var selectedTab = 0
        var body: some View {
            NavigationView {
                Group {
                    if newsController.isLoading {
                        ProgressView("Loading Articles")
                    } else {
                        VStack {
                            List(newsController.newsArticles) { article in
                                NavigationLink(
                                    destination: ArticleDetailView(article: article)
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
                                        .padding(.vertical)
                                        
                                        if (article.isLiked) {
                                            Label("", systemImage: "heart.fill")
                                                        .font(.system(size: 14))
                                                        .foregroundColor(.red)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .listStyle(PlainListStyle())
                            .navigationBarTitle("Article News", displayMode: .inline)
                            .navigationBarItems(trailing: Button(action: {
                                // Handle logout action here
                                presentationMode.wrappedValue.dismiss()
                                viewModel.logout()
                            }) {
                                Text("Logout")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            })
                        }
                    }
                }
                .onAppear {
                    newsController.fetchAllNewsData()
                }
                
            }
            .navigationBarHidden(true)
        }
}


//struct ArticleListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleListView()
//    }
//}


