//
//  APIServiceInterface.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation

protocol APIServiceInterface {
    var isReachable: Bool { get }
    func request<T: Decodable>(for request: Requestable, completion: @escaping (Result<APIHTTPDecodableResponse<T>, Error>) -> Void)
    func dataRequest(for request: Requestable, completion: @escaping (Result<APIHTTPDataResponse, Error>) -> Void)
}
