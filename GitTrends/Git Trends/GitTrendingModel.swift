//
//  GitTrendingModel.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation

struct TrendingRepos: Decodable {
    let items: [Items]
}

struct Items: Decodable {
    let name: String
    let html_url: String
    let description: String
    let language: String?
    let stargazers_count, forks_count: Int
    let owner: Owner
}

// MARK: - BuiltBy
struct Owner: Decodable {
    let url, avatar_url: String
    let login: String
}

typealias Repos = TrendingRepos
