//
//  GitDetailViewController.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation
import UIKit

class GitDetailViewController: UIViewController {

    private let viewModel: GitTrendingRowViewModel
    private let gitDetailView = GitDetailView()

    init(viewModel: GitTrendingRowViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = UIView()
        view.addSubview(gitDetailView)
        gitDetailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gitDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gitDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gitDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: (self.navigationController?.navigationBar.frame.height)! + 40),
            gitDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        view.backgroundColor = .white
        self.title = viewModel.author
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        gitDetailView.update(with: viewModel)
    }
}
