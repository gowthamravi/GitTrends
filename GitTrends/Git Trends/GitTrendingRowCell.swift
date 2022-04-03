//
//  GitTrendingRowCell.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation
import UIKit

final class GitTrendingRowCell: UITableViewCell {
    private let leadingConstraint: CGFloat = 8
    private let trailingConstraint: CGFloat = -8

    private let name: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    private let favouriteIcon: UIImageView = {
        let img = UIImageView()
        return img
    }()

    private let favouriteCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    private let gitDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setupHierarchy()
        applyConstraints()
    }

    private func setupHierarchy() {
        self.contentView.addSubviews(name, favouriteIcon, favouriteCount, gitDescription)
    }

    private func applyConstraints() {
        name.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingConstraint),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingConstraint),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])

        favouriteIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favouriteIcon.widthAnchor.constraint(equalToConstant: 20),
            favouriteIcon.heightAnchor.constraint(equalToConstant: 20),
            favouriteIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingConstraint),
            favouriteIcon.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8)
        ])

        favouriteCount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favouriteCount.leadingAnchor.constraint(equalTo: favouriteIcon.leadingAnchor, constant: 24),
            favouriteCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingConstraint),
            favouriteCount.centerYAnchor.constraint(equalTo: favouriteIcon.centerYAnchor)
        ])

        gitDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gitDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingConstraint),
            gitDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingConstraint),
            gitDescription.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 68)
        ])
    }

    func configureCell(item: GitTrendingRowViewModel) {
        name.text = item.author
        favouriteIcon.image = #imageLiteral(resourceName: "star")
        favouriteCount.text = item.starCount
        gitDescription.text = item.description
    }
}
