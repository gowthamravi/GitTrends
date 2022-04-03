//
//  GitTrendingUseCaseSpy.swift
//  GitTrendsTests
//
//  Created by Ravikumar, Gowtham.
//

import Foundation
@testable import GitTrends

final class GitTrendingUseCaseSpy: TrendingUseCase {

    func fetchTopGitTrending(with completion: @escaping (Result<Repos, Error>) -> Void, forcely: Bool) {
        if let repos = Utils.readJSONFromFile(fileName: "repositories", type: Repos.self) {
            DispatchQueue.main.async {
                completion(.success(repos))
            }
        }
    }
}
