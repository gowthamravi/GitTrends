//
//  GitDetailView.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation
import UIKit
import WebKit

final class GitDetailView: UIView {
    static private let iconSize: CGFloat = 75.0

    lazy var yPos: CGFloat = {
        self.frame.origin.y
    }()

    private let icon: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.layer.cornerRadius = iconSize/2
        img.translatesAutoresizingMaskIntoConstraints = false

        return img
    }()

    private let name: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24.0)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let horizontalDividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let gitDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let starCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let verticleDividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let forkCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let readMe: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Readme.md"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false

        return webView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GitDetailView {
    func setup() {
        setupHierarchy()
        applyConstraints()
    }

    private func setupHierarchy() {
        addSubviews(icon,
                    name,
                    horizontalDividerLine,
                    gitDescription,
                    starCount,
                    verticleDividerLine,
                    forkCount,
                    readMe,
                    webView)
    }

    func applyConstraints() {
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: GitDetailView.iconSize),
            icon.heightAnchor.constraint(equalToConstant: GitDetailView.iconSize),
            icon.centerXAnchor.constraint(equalTo: centerXAnchor),
            icon.topAnchor.constraint(equalTo: topAnchor, constant: yPos + 20)
        ])

        NSLayoutConstraint.activate([
            name.centerXAnchor.constraint(equalTo: icon.centerXAnchor),
            name.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            horizontalDividerLine.widthAnchor.constraint(equalToConstant: 40),
            horizontalDividerLine.heightAnchor.constraint(equalToConstant: 1),
            horizontalDividerLine.centerXAnchor.constraint(equalTo: name.centerXAnchor),
            horizontalDividerLine.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            gitDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            gitDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            gitDescription.topAnchor.constraint(equalTo: horizontalDividerLine.bottomAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            verticleDividerLine.widthAnchor.constraint(equalToConstant: 1),
            verticleDividerLine.heightAnchor.constraint(equalToConstant: 20),
            verticleDividerLine.topAnchor.constraint(equalTo: gitDescription.bottomAnchor, constant: 50),
            verticleDividerLine.centerXAnchor.constraint(equalTo: gitDescription.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            forkCount.topAnchor.constraint(equalTo: verticleDividerLine.topAnchor),
            forkCount.bottomAnchor.constraint(equalTo: verticleDividerLine.bottomAnchor),
            forkCount.leadingAnchor.constraint(equalTo: verticleDividerLine.trailingAnchor, constant: 10)
        ])

        NSLayoutConstraint.activate([
            starCount.topAnchor.constraint(equalTo: verticleDividerLine.topAnchor),
            starCount.bottomAnchor.constraint(equalTo: verticleDividerLine.bottomAnchor),
            starCount.trailingAnchor.constraint(equalTo: verticleDividerLine.leadingAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            readMe.topAnchor.constraint(equalTo: verticleDividerLine.bottomAnchor, constant: 10),
            readMe.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: readMe.bottomAnchor, constant: 10),
            webView.centerXAnchor.constraint(equalTo: gitDescription.centerXAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}

extension GitDetailView: WKUIDelegate {}

extension GitDetailView {
    func update(with viewModel: GitTrendingRowViewModel) {
        let url = viewModel.repoURL + "#readme"
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        icon.load(url: URL(string: viewModel.authorIcon)!)
        gitDescription.text = viewModel.description

        let forkAttString = NSMutableAttributedString()
        let forkAttachment = NSTextAttachment()
        forkAttachment.image = #imageLiteral(resourceName: "fork")
        forkAttachment.bounds = CGRect(x: 0, y: -5, width: 20, height: 20)
        forkAttString.append(NSAttributedString(attachment: forkAttachment))
        forkAttString.append(NSAttributedString(string: viewModel.forkCount + " Forks"))
        forkCount.attributedText = forkAttString

        let starAttString = NSMutableAttributedString()
        let starAttachment = NSTextAttachment()
        starAttachment.image = #imageLiteral(resourceName: "star")
        starAttachment.bounds = CGRect(x: 0, y: -5, width: 20, height: 20)
        starAttString.append(NSAttributedString(attachment: starAttachment))
        starAttString.append(NSAttributedString(string: viewModel.starCount + " Stars"))
        starCount.attributedText = starAttString

        name.text = viewModel.authorName
    }
}
