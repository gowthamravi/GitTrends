//
//  RequestEncoding.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation
import Alamofire

protocol RequestEncoding {
    func encode(_ request: URLRequest, with parameters: RequestParameters) throws -> URLRequest
}

struct GetRequestEncoding: RequestEncoding {

    func encode(_ request: URLRequest, with parameters: RequestParameters) throws -> URLRequest {
        return try URLEncoding().encode(request, with: parameters)
    }
}

struct PostRequestEncoding: RequestEncoding {

    func encode(_ request: URLRequest, with parameters: RequestParameters) throws -> URLRequest {
        return try JSONEncoding().encode(request, with: parameters)
    }
}
