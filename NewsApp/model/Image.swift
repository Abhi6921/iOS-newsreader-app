//
//  Image.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 10/02/2024.
//

import SwiftUI

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
