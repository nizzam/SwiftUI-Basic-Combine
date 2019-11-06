//
//  Model.swift
//  SwiftUI-Basic-Combine
//
//  Created by Nizzammuddin on 31/10/2019.
//  Copyright © 2019 buckner. All rights reserved.
//

import SwiftUI

enum HTTPError: Error {
    case statusCode
    case post
}

struct Post: Decodable, Identifiable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

struct Todo: Codable {
    let id: Int
    let title: String
    let completed: Bool
    let userId: Int
}

struct Photo: Decodable, Identifiable {
    let id: Int
    let albumId: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
