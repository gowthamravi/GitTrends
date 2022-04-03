//
//  APIResponse.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation

struct APIHTTPDataResponse {
    let data: Data
    let httpResponse: HTTPURLResponse?
}

struct APIHTTPDecodableResponse<T> where T: Decodable {
    let data: Data
    let decoded: T
    let httpResponse: HTTPURLResponse?
}
