//
//  PostRepositoryRequest.swift
//  SwiftUI-Basic-Combine
//
//  Created by Nizzammuddin on 01/11/2019.
//  Copyright © 2019 buckner. All rights reserved.
//

import Foundation

struct PostRepositoryRequest: APIRequestType {
    typealias Response = [Post]
    
    var path: String {
        "/posts"
    }
    var queryItems: [URLQueryItem]? {
        nil
    }
}
