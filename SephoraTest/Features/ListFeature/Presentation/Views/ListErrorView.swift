//
//  ListErrorView.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 06/01/2024.
//

import UIKit

protocol ErrorViewDelegate: AnyObject {
    func didTapRetryButton()
}

final class ErrorView: UIView {
    private lazy var retryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(String(localized: "listErrorButton", table: "ListFeature"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray2.cgColor
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.setTitleColor(UIColor.systemGray2, for: .normal)
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.didTapRetryButton()
        }), for: .touchUpInside)
        button.layer.cornerRadius = 8
        return button
    }()
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .systemGray2
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = String(localized: "listErrorMessage", table: "ListFeature")
        return label
    }()
    private let errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "errorPlaceholder")?.withTintColor(.systemGray2, renderingMode: .alwaysTemplate)
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    weak var delegate: ErrorViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            self.errorImageView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.3),
            self.errorImageView.heightAnchor.constraint(equalTo: self.errorImageView.widthAnchor),
            self.errorLabel.widthAnchor.constraint(equalToConstant: self.frame.width * 0.6)
        ])
    }

    private func setupUI() {
        self.addSubview(self.retryButton)
        self.addSubview(self.errorLabel)
        self.addSubview(self.errorImageView)

        // MARK: - ErrorImageView
        NSLayoutConstraint.activate([
            self.errorImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.errorImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

        // MARK: - ErrorLabel
        NSLayoutConstraint.activate([
            self.errorLabel.topAnchor.constraint(equalTo: self.errorImageView.bottomAnchor, constant: 32),
            self.errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

        // MARK: - RetryButton
        NSLayoutConstraint.activate([
            self.retryButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.retryButton.topAnchor.constraint(equalTo: self.errorLabel.bottomAnchor, constant: 24),
            self.retryButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0/2.0),
            self.retryButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0/6.0)
        ])
    }
}
