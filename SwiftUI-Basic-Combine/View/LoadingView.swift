//
//  LoadingView.swift
//  SwiftUI-Basic-Combine
//
//  Created by Nizzammuddin on 04/11/2019.
//  Copyright © 2019 buckner. All rights reserved.
//

import SwiftUI

//  If you want custom
struct LoadingView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3: 0)
                
                VStack {
                    Text("Loading")
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1: 0)
            }
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    var style: UIActivityIndicatorView.Style = .medium
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating(): uiView.stopAnimating()
    }
}
