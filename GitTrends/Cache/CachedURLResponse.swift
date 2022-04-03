//
//  CachedURLResponse.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation

extension CachedURLResponse {

    func decoded<T: Decodable>(with decodableType: T.Type) throws -> T {
        try JSONDecoder().decode(T.self, from: self.data) as T
    }
}
