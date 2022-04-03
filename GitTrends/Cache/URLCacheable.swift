//
//  URLCacheable.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation

typealias URLCacheableStoreCompletion = (Result<Bool, Error>) -> Void

protocol URLCacheable {
    func store<T: Decodable>(response: APIHTTPDecodableResponse<T>, forRequest request: CacheRequestable, completion: URLCacheableStoreCompletion?)
    func get<T: Decodable>(forRequest request: CacheRequestable, completion: @escaping (Result<APIHTTPDecodableResponse<T>?, Error>) -> Void)
}
