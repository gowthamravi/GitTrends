//
//  URLRequest+Extension.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation

extension URLRequest {
    init(with url: URLFormable, method: RequestMethod, headers: [String: String]?) throws {
        self.init(url: try url.asURL())
        self.httpMethod = method.rawValue
        self.allHTTPHeaderFields = headers
    }
}
