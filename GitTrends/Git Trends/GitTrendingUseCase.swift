//
//  GitTrendingUseCase.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation

protocol TrendingUseCase {
    func fetchTopGitTrending(with completion: @escaping (Result<Repos, Error>) -> Void, forcely: Bool)
}

final class GitTrendingUseCase: TrendingUseCase {

    let apiService: APIServiceInterface
    let cache: URLCacheable

    init(apiService: APIServiceInterface, cache: URLCacheable) {
        self.apiService = apiService
        self.cache = cache
    }

    func fetchTopGitTrending(with completion: @escaping (Result<Repos, Error>) -> Void, forcely: Bool) {

        let url = Api().baseURL
        let cacheableRequest = CacheableRequest(request: Request(url: url,
                                                        method: .get,
                                                        parameters: nil,
                                                        headers: nil,
                                                        encoding: GetRequestEncoding()),
                                       expiry: .aged(TimeInterval.twoHours))

        let responseClosure: (Result<APIHTTPDecodableResponse<Repos>, Error>) -> Void = { [weak self] result in
            self?.handleResult(result, request: cacheableRequest, fromCache: false, completion: completion)
        }

        guard forcely else {
            guard self.apiService.isReachable else {
                self.cache.get(forRequest: cacheableRequest) { [weak self] (result: Result<APIHTTPDecodableResponse<Repos>?, Error>) in
                    switch result {
                    case .success(let response):
                        guard let response = response else {
                            self?.apiService.request(for: cacheableRequest.request, completion: responseClosure)
                            return
                        }
                        self?.handleResult(.success(response), request: cacheableRequest, fromCache: true, completion: completion)
                    case .failure(let error):
                        self?.handleResult(.failure(error), request: cacheableRequest, fromCache: false, completion: completion)
                    }
                }
                return
            }
            return
        }

        let request = Request(url: url,
                              method: .get,
                              parameters: nil,
                              headers: nil,
                              encoding: GetRequestEncoding())

        self.apiService.request(for: request, completion: responseClosure)
    }

    private func handleResult(_ result: Result<APIHTTPDecodableResponse<Repos>, Error>,
                              request: CacheableRequest,
                              fromCache: Bool,
                              completion: @escaping (Result<Repos, Error>) -> Void) {
        switch result {
        case .success(let response):
            DispatchQueue.main.async {
                completion(.success(response.decoded))
            }
        case .failure(let error):
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
}
