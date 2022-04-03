//
//  GitTrendingViewModel.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation
import UIKit

struct GitTrendingViewModel {
    var rows: [GitTrendingRow]
}

struct GitTrendingRowViewModel {
    let author: String
    let authorIcon: String
    let authorName: String
    let description: String
    let starCount: String
    let forkCount: String
    let repoURL: String
}

enum TrendingIcon: String {
    case favorite

    var image: UIImage {
        switch self {
        case .favorite: return UIImage(named: "favourite")!
        }
    }
}

enum GitTrendingRow: Equatable {
    case gitTrendingDetails(viewModel: GitTrendingRowViewModel)

    static func == (lhs: GitTrendingRow, rhs: GitTrendingRow) -> Bool {
        switch (lhs, rhs) {
        case (.gitTrendingDetails(let a), .gitTrendingDetails(let b)):
            return a.repoURL == b.repoURL
        }
    }
}
