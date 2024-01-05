//
//  ListItemTableViewCell.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import UIKit

final class ListItemTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ListItemTableViewCell"
    
    var viewModel: ListItemTableViewCellViewModel?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        return label
    }()
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let itemImageSize: CGFloat = 120

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.itemImageView.image = nil
        self.viewModel = nil
    }

    private func setupUI() {
        self.selectionStyle = .none

        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.priceLabel)
        self.addSubview(self.brandLabel)
        self.addSubview(self.itemImageView)

        // MARK: - Image
        NSLayoutConstraint.activate([
            self.itemImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.itemImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            self.itemImageView.heightAnchor.constraint(equalToConstant: self.itemImageSize),
            self.itemImageView.widthAnchor.constraint(equalToConstant: self.itemImageSize)
        ])

        // MARK: - Title
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.itemImageView.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.itemImageView.trailingAnchor, constant: 8),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])

        // MARK: - Description
        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor)
        ])

        // MARK: - Price
        NSLayoutConstraint.activate([
            self.priceLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 4),
            self.priceLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor)
        ])

        // MARK: - Brand
        NSLayoutConstraint.activate([
            self.brandLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 4),
            self.brandLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.brandLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }

    func configure(with viewModel: ListItemTableViewCellViewModel) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.item.productName
        self.descriptionLabel.text = viewModel.item.description
        self.priceLabel.text = viewModel.item.price
        self.brandLabel.text = viewModel.item.cBrand.name
    }
}
