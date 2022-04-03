//
//  URLFormable.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation

protocol URLFormable {
    func asURL() throws -> URL
}

extension String: URLFormable {

    func asURL() throws -> URL {
        guard let url = URL(string: self) else {
            throw APIServiceError.URLFormableError.failed
        }
        return url
    }
}

extension URL: URLFormable {

    func asURL() throws -> URL {
        return self
    }
}
