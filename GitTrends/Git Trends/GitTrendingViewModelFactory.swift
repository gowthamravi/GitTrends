//
//  GitTrendingViewModelFactory.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation

final class GitTrendingViewModelFactory {
    func viewModel(for trendingRepos: Repos) -> GitTrendingViewModel {
        return GitTrendingViewModel(rows: trendingRepos.items.map {
            let viewModel = GitTrendingRowViewModel(author: $0.name,
                                                    authorIcon: $0.owner.avatar_url,
                                                    authorName: $0.owner.login,
                                                    description: $0.description,
                                                    starCount: "\($0.stargazers_count)",
                                                    forkCount: "\($0.forks_count)",
                                                    repoURL: $0.html_url)
            return GitTrendingRow.gitTrendingDetails(viewModel: viewModel)
        })
    }
}
