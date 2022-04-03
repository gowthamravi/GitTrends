//
//  GitTrendingNavigator.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation
import UIKit

protocol GitTrendingNavigator: AnyObject {
    var navController: UINavigationController? { get }
    func toGitDetailView(model: GitTrendingRow)
}

final class GitTrendingViewNavigator: GitTrendingNavigator {
    var navController: UINavigationController?

    init(navigation: UINavigationController?) {
        self.navController = navigation
    }

    func toGitDetailView(model: GitTrendingRow) {
        switch model {
        case .gitTrendingDetails(let detailModel):
            let detail = GitDetailViewController(viewModel: detailModel)
            navController?.pushViewController(detail, animated: true)
        }
    }
}
