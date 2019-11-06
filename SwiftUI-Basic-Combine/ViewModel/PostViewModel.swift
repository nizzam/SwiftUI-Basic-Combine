//
//  PostViewModel.swift
//  SwiftUI-Basic-Combine
//
//  Created by Nizzammuddin on 01/11/2019.
//  Copyright © 2019 buckner. All rights reserved.
//

import Foundation
import Combine

class PostViewModel: ObservableObject {
    
    private var cancellables: [AnyCancellable] = []
    
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    
    //  MARK:- Response
    private let responseSubject = PassthroughSubject<[Post], Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    
    @Published private(set) var postRepo: [Post] = []
    @Published var errorMessage = ""
    @Published var isErrorShown = false
    
    
    private let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
        
        setupInputs()
        setupOutputs()
    }
    
    func start() {
        onAppearSubject.send()
    }
    
    private func setupInputs() {
        let request = PostRepositoryRequest()
        let responsePublisher = onAppearSubject
            .flatMap { [apiService] _ in
                apiService.response(from: request)
                    .catch { [weak self] error -> Empty<[Post], Never> in
                        self?.errorSubject.send(error)
                        return .init()
                }
            }
        
        let responseStream = responsePublisher
            .share()
            .subscribe(responseSubject)
        
        cancellables += [
            responseStream
        ]
    }
    
    private func setupOutputs() {
        let repositoriesStream = responseSubject
            .map { $0 }
            .assign(to: \.postRepo, on: self)
        
        let errorMessageStream = errorSubject
            .map { error -> String in
                switch error {
                case .responseError: return "network error"
                case .parseError(let errMessage) : return "parse error: \(errMessage)"
                }
            }
            .assign(to: \.errorMessage, on: self)
        
        let errorStream = errorSubject
            .map { _ in true }
            .assign(to: \.isErrorShown, on: self)
        
        cancellables += [
            repositoriesStream,
            errorStream,
            errorMessageStream
        ]
    }
}
