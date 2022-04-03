//
//  GitTrendingCellFactory.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation
import UIKit

final class GitTrendingCellFactory {

    static private let resueableCellID = "GitTrendingRowCellID"

    static func registerCells(for tableView: UITableView) {
        tableView.register(GitTrendingRowCell.self, forCellReuseIdentifier: GitTrendingCellFactory.resueableCellID)
    }

    func cell(for viewModel: GitTrendingRow,
              at indexPath: IndexPath,
              in tableView: UITableView,
              using actionListener: GitTrendingActionlistener?) -> UITableViewCell {
        switch viewModel {
        case .gitTrendingDetails(let viewRowModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: GitTrendingCellFactory.resueableCellID, for: indexPath) as! GitTrendingRowCell
            cell.configureCell(item: viewRowModel)
            return cell
        }
    }

    func heightForRow(for viewModel: GitTrendingRow,
                      at indexPath: IndexPath,
                      in tableView: UITableView) -> CGFloat {
        switch viewModel {
        case .gitTrendingDetails(let viewRowModel):
            return viewRowModel.description.heightWithConstrainedWidth(width: tableView.frame.width-32,
                                                                       font: UIFont.systemFont(ofSize: 16)) + 68
        }
    }
}
