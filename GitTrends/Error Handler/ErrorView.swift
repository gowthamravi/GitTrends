//
//  ErrorView.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import Foundation
import UIKit

protocol ErrorViewable {
    func attachError(handler: @escaping ((_ value: Bool?) -> Void))
    func dettachError()
}

final class ErrorView: UIView {

    private let image: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "error"))
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    private let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        label.text = "Something went wrong..."
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let errorDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "An alien is probably blocking your signal."
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let retryButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.layer.cornerRadius = 5.0
        button.setTitle("RETRY", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    var retryHandler: ((_ value: Bool?) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setupHierarchy()
        applyConstraints()
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
    }

    @objc func retryTapped() {
        retryHandler?(true)
    }
}

extension ErrorView {
    private func setupHierarchy() {
        addSubviews(image,
                    title,
                    errorDescription,
                    retryButton)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            image.heightAnchor.constraint(equalToConstant: 300),
            image.widthAnchor.constraint(equalToConstant: 300),
            image.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            title.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            errorDescription.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            errorDescription.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            retryButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -180),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.heightAnchor.constraint(equalToConstant: 50),
            retryButton.widthAnchor.constraint(equalToConstant: self.frame.width - 80)
        ])
    }
}
