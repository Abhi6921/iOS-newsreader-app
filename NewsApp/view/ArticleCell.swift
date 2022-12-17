//
//  ArticleView.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 29/10/2022.
//

import SwiftUI

struct ArticleCell: View {
    let article: Article
    let imageSize: CGFloat = 130
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: article.image)
            ) { image in
                  image
                      .resizable()
                      .scaledToFit()
                      .frame(width: imageSize, height: 130,alignment: .leading)
                      .clipped()
                      .cornerRadius(8)
                      
              } placeholder: {
                  // replace this with placeholder image
                  Color.gray
              }
              
            VStack(alignment: .leading, spacing: 45) {
                Text("\(article.title)").font(.system(size: 19))
                
            }
        }
    }
}

struct ArticleCell_Previews: PreviewProvider {
    static var previews: some View {
        ArticleCell(article: .testArticle)
    }
}
