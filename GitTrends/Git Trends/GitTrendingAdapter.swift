//
//  GitTrendingAdapter.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation
import UIKit

final class GitTrendingAdapter: NSObject {
    private var actionListener: GitTrendingActionlistener?
    private var viewModel: GitTrendingViewModel?
    private let cellFactory = GitTrendingCellFactory()

    func attachListener(listener: GitTrendingActionlistener) {
        actionListener = listener
    }

    func detachListener() {
        actionListener = nil
    }

    func update(tableView: UITableView, viewModel: GitTrendingViewModel) {
        self.viewModel = viewModel
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.reloadData()
    }
}

extension GitTrendingAdapter: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.rows.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellFactory.cell(for: rowViewModel(at: indexPath), at: indexPath, in: tableView, using: actionListener)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension GitTrendingAdapter: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellFactory.heightForRow(for: rowViewModel(at: indexPath), at: indexPath, in: tableView)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        actionListener?.toGitDetailView(rowViewModel(at: indexPath))
    }
}

extension GitTrendingAdapter {
    private func rowViewModel(at indexPath: IndexPath) -> GitTrendingRow {
        guard let model = viewModel?.rows[indexPath.row] else {
                preconditionFailure("Expected a setting row at \(indexPath)")
        }

        return model
    }
}
