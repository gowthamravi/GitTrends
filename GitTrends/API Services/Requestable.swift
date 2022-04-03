//
//  Requestable.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation

typealias RequestParameters = [String: Any]
typealias RequestHeaders = [String: String]

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol Requestable {
    func asURLRequest() throws -> URLRequest
}

extension URLRequest: Requestable {

    func asURLRequest() throws -> URLRequest {
        return self
    }
}

enum CacheExpiry {
    case never
    case aged(TimeInterval)
}

protocol CacheRequestable: Requestable {
    var expiry: CacheExpiry { get }
}
