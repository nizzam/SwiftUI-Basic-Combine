//
//  MockAPIService.swift
//  SwiftUI-Basic-CombineTests
//
//  Created by Nizzammuddin on 07/11/2019.
//  Copyright © 2019 buckner. All rights reserved.
//

import Foundation
import Combine
@testable import SwiftUI_Basic_Combine

final class MockAPIService: APIServiceType {
    var stubs: [Any] = []
    
    func stub<Request>(for type: Request.Type, response: @escaping ((Request) -> AnyPublisher<Request.Response, APIServiceError>)) where Request: APIRequestType {
        stubs.append(response)
    }
    
    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request : APIRequestType {
        let response = stubs.compactMap { stub -> AnyPublisher<Request.Response, APIServiceError>? in
            let stub = stub as? ((Request) -> AnyPublisher<Request.Response, APIServiceError>)
            return stub?(request)
        }.last
        
        return response ?? Empty<Request.Response, APIServiceError>().eraseToAnyPublisher()
    }
}
