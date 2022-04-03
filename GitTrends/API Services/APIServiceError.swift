//
//  APIServiceError.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation

enum APIServiceError: Error {
    enum URLFormableError: Error {
        case failed
    }

    enum CacheableRequestError: Error {
        case invalidMethod
    }
}
