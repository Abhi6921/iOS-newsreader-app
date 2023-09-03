//
//  ArticleListView.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 06/07/2023.
//

import SwiftUI

struct ArticleListView: View {
    @StateObject private var newsController = NewsController()
        @Environment(\.presentationMode) var presentationMode // Add this environment variable
        var body: some View {
            NavigationView {
                Group {
                    if newsController.isLoading {
                        ProgressView("Loading Articles")
                    } else {
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
                                }
                                .padding(.horizontal)
                            }
                        }
                        .listStyle(PlainListStyle())
                        .navigationBarTitle("Article News", displayMode: .inline)
                        .navigationBarItems(trailing: Button(action: {
                            // Handle logout action here
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Logout")
                                .font(.headline)
                                .foregroundColor(.blue)
                        })
                    }
                }
                .onAppear {
                    newsController.fetchAllNewsData()
                }
            }
            .navigationBarHidden(true)
        }
}


struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView()
    }
}

struct RemoteImage: View {
    @StateObject private var imageLoader: ImageLoader
    
    init(url: String) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
        } else {
            // Placeholder image or activity indicator
            Color.gray
                .frame(width: 80, height: 80)
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    init(url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
