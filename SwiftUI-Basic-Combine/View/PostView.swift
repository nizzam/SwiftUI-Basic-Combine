//
//  ContentView.swift
//  SwiftUI-Basic-Combine
//
//  Created by Nizzammuddin on 31/10/2019.
//  Copyright © 2019 buckner. All rights reserved.
//

import SwiftUI
import Combine

struct PostView: View {
    @ObservedObject var viewModel: PostViewModel
    @State private var showDetails: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isErrorShown {
                    Text(viewModel.errorMessage)
                    
                } else if viewModel.postRepo.isEmpty {
                    ActivityIndicator(isAnimating: .constant(true))
                    
                } else {
                    List {
                        TrendingView(postArray: self.viewModel.postRepo)
                            .listRowInsets(EdgeInsets())
                        
                        ForEach(viewModel.postRepo) { item in
                            NavigationLink(destination: PostViewDetails(postItem: item)) {
                                PostViewRow(postItem: item)
                            }
                        }
                    }
                }
            }
            .navigationBarItems(trailing: showButton)
            .navigationBarTitle(Text("All da posts !!"))
        }
        .onAppear {
            //  Perform a delay
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.viewModel.start()
            }
        }
    }
    
    var showButton: some View {
        Button(action: {
            self.showDetails.toggle()
        }) {
            Text("Show")
        }.sheet(isPresented: $showDetails) {
            ShowDetailView()
        }
    }
}

struct TrendingView: View {
    var postArray: [Post]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Trending")
                .font(.headline)
                .padding(.top, 5)
                .padding(.leading, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                   ForEach(self.postArray) { item in
                        TrendingViewRow(postItem: item)
                   }
                }
            }
        }
    }
}

struct TrendingViewRow: View {
    var postItem: Post
    
    var body: some View {
        VStack {
            Image("trees")
                .resizable()
                .frame(width: 155, height: 155)
            Text("Content \(postItem.id)")
                .foregroundColor(Color.white)
            Spacer().frame(height: 10)
        }
        .background(Color.black)
        .cornerRadius(5)
        .padding(.leading, 20)
        .padding(.bottom, 5)
        .shadow(color: Color.gray, radius: 2, x: 0, y: 0)
    }
}


struct ShowDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("Its show detailssss")
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Dismiss This View")
            }
        }
    }
}

struct PostViewRow: View {
    var postItem: Post
    
    var body: some View {
        ZStack {
            Image("trees")
                .resizable()
            
            Text(self.postItem.title)
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding([.leading, .trailing, .top], 10)
                .shadow(color: Color.black, radius: 3, x: 0, y: 0)
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 2)
        )
        .padding([.top, .bottom], 10)
        .shadow(color: Color.gray, radius: 3, x: 0, y: 0)
    }
}

struct PostViewDetails: View {
    var postItem: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(postItem.body).lineLimit(nil)
            Spacer()
        }.padding()
    }
}


#if DEBUG
struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(viewModel: .init())
    }
}
#endif
