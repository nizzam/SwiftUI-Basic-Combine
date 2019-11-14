//
//  PostViewModelTest.swift
//  SwiftUI-Basic-CombineTests
//
//  Created by Nizzammuddin on 07/11/2019.
//  Copyright © 2019 buckner. All rights reserved.
//

import Foundation
import XCTest
import Combine
@testable import SwiftUI_Basic_Combine

final class PostViewModelTest: XCTestCase {
    
    func test_updatePostViewModelWhenOnAppear() {
        let apiService = MockAPIService()
        apiService.stub(for: PostRepositoryRequest.self) { _ in
            Result.Publisher(
                [Post(id: 0, title: "Content 1", body: "Nation all the way", userId: 0),
                 Post(id: 1, title: "Content 2", body: "Nation all the way", userId: 1),
                 Post(id: 2, title: "Content 3", body: "Nation all the way", userId: 2)]
            ).eraseToAnyPublisher()
        }
        let viewModel = makeViewModel(apiService: apiService)
        viewModel.start()
        XCTAssertTrue(!viewModel.postRepo.isEmpty)
    }
    
    private func makeViewModel(apiService: APIServiceType = MockAPIService()) -> PostViewModel {
        return PostViewModel(apiService: apiService)
    }
}
