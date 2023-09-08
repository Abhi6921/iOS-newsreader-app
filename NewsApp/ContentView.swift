//
//  ContentView.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 29/10/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            LoginView()
        }
    }
}
// TODO: Make the register user functionality work DONE
// TODO: add navigation bar
// TODO: load the favorited articles by passing the authtoken key
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

