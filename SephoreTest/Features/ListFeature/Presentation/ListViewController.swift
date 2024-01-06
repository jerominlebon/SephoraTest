//
//  ListViewController.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import UIKit

class ListViewController: UIViewController {
    weak var coordinator: AppCoordinator?
    private let viewModel = ListViewModel()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListItemTableViewCell.self, forCellReuseIdentifier: ListItemTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        return tableView
    }()
    private lazy var errorView: ErrorView = {
        let errorView = ErrorView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.delegate = self
        return errorView
    }()

    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
        self.title = String(localized: "controllerTitle", table: "ListFeature")
        self.setupUI()
        self.bindViewModel()
        self.viewModel.initViewModel()
    }

    private func setupUI() {
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.errorView)

        // MARK: - TableView
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        // MARK: - ErrorView
        NSLayoutConstraint.activate([
            self.errorView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.errorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.errorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.errorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        self.errorView.isHidden = true
    }

    private func bindViewModel() {
        self.viewModel.reloadTableViewClosure = { [weak self] in
            self?.errorView.isHidden = true
            self?.tableView.reloadData()
        }

        self.viewModel.didGetErrorClosure = { [weak self] in
            self?.errorView.isHidden = false
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.cellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListItemTableViewCell.reuseIdentifier) as? ListItemTableViewCell else {
            fatalError("[ListViewController] unable to dequeue cell")
        }
        cell.configure(with: self.viewModel.cellViewModels[indexPath.row])
        return cell
    }
}

extension ListViewController: ErrorViewDelegate {
    func didTapRetryButton() {
        self.viewModel.initViewModel()
    }
}
