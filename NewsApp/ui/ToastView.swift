//
//  ToastView.swift
//  NewsApp
//
//  Created by Abhishek Narvekar on 15/02/2024.
//

import SwiftUI

struct ToastView: View {
    
    var message: String
    @Binding var isShowing: Bool
    
    var body: some View {
        if isShowing {
            VStack {
                Spacer()
                Text(message)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(8)
                    .padding()
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.3))
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isShowing = false
                    }
                }
            }
        }
    }
}

//struct ToastView_Previews: PreviewProvider {
//    static var previews: some View {
//        ToastView()
//    }
//}
