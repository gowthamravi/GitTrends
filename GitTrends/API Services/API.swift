//
//  API.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation

struct Api {
    var baseURL: URL {
        return URL(string: "https://api.github.com/search/repositories?q=ios&sort=stars&order=desc")!
    }
}
