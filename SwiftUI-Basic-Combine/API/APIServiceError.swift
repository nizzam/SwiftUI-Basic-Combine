//
//  APIServiceError.swift
//  SwiftUI-Basic-Combine
//
//  Created by Nizzammuddin on 01/11/2019.
//  Copyright © 2019 buckner. All rights reserved.
//

import Foundation

enum APIServiceError: Error {
    case responseError
    case parseError(Error)
}
