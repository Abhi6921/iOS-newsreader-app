//
//  ArticleView.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 29/10/2022.
//

import SwiftUI

struct ArticleCell: View {
    
    let article: ArticleResult
    
    var body: some View {
        HStack {
            let imageUrl = URL(string: article.image)
            AsyncImage(
                url: imageUrl,
                content: { image in
                    image.resizable()
                },
                placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            )
            .frame(width: 100, height: 100)
            Text(article.title)
        }
    }
}

struct ArticleCell_Previews: PreviewProvider {
    static var previews: some View {
        ArticleCell(article: ArticleResult(id: 0, feed: 0, title: "News Title",
                    summary: "Some summary",
                    publishDate: "some date",
                    image: "https://media.nu.nl/m/bd6xpyzaw32r_sqr256.jpg/brighton-predikt-prudence-met-valse-start-maken-we-levens-kapot.jpg",
                    url: "",
                    isLiked: false))
    }
}
