//
//  GitTrendingView.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation
import UIKit

protocol GitTrendingDisplayer: ErrorViewable {
    func attachListener(listener: GitTrendingActionlistener)
    func detachListener()
    func attachRefresh(handler: ((_ value: Bool?) -> Void)?)
    func detachRefresh()
    func update(with viewModel: GitTrendingViewModel)
}

final class GitTrendingView: UIView {
    private let tableView: UITableView
    private let adapter = GitTrendingAdapter()
    private let refreshControl = UIRefreshControl()
    private var refreshHandler: ((_ value: Bool?) -> Void)?
    private let errorView: ErrorView

    override init(frame: CGRect) {
        tableView = UITableView(frame: frame, style: .plain)
        errorView = ErrorView(frame: frame)
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        backgroundColor = .clear
        setupTableView()
        applyConstraints()
    }

    func setupTableView() {
        addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.separatorStyle = .none
        tableView.addSubviews(refreshControl, errorView)
        errorView.isHidden = true
        refreshControl.addTarget(self, action: #selector(refresh(handler:)), for: .valueChanged)
        GitTrendingCellFactory.registerCells(for: tableView)
    }

    func attachRefresh(handler: ((_ value: Bool?) -> Void)?) {
        self.refreshHandler = handler
    }

    func applyConstraints() {
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
}

extension GitTrendingView: GitTrendingDisplayer {
    func attachListener(listener: GitTrendingActionlistener) {
        adapter.attachListener(listener: listener)
    }

    func update(with viewModel: GitTrendingViewModel) {
        adapter.update(tableView: tableView, viewModel: viewModel)
    }

    func detachListener() {
        adapter.detachListener()
    }

    func detachRefresh() {
        refreshControl.endRefreshing()
    }

    @objc func refresh(handler: (Bool) -> Void) {
        refreshHandler?(true)
    }
}

extension GitTrendingView {
    func attachError(handler: @escaping ((_ value: Bool?) -> Void)) {
        errorView.isHidden = false

        errorView.retryHandler = handler
    }

    func dettachError() {
        errorView.isHidden = true
    }
}
