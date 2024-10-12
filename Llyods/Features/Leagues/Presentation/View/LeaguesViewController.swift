//
//  LeaguesViewController.swift
//  Llyods
//
//  Created by Vinoth Palanisamy on 10/10/2024.
//

import UIKit

final class LeaguesViewController: UIViewController {
    
    private var viewModel: LeaguesViewModel
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        return searchBar
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        return tableView
    }()
    
    init(viewModel: LeaguesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        activateConstraints()
        viewModel.loadLeagues()
            .done { [weak self] in
                self?.tableView.reloadData()
            }.catch { error in
                debugPrint(error)
            }
    }
    
    // MARK :- View Setup
    
    private func setUpViews() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
        tableView.register(LeagueTableViewCell.self, forCellReuseIdentifier: LeagueTableViewCell.identifier)
    }
    
    private func activateConstraints() {
        let searchBarConstraints = [
            searchBar.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(searchBarConstraints + tableViewConstraints)
    }
    
}

// MARK: UISearchBarDelegate

extension LeaguesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(query: searchText)
            .done { [weak self] in
                self?.tableView.reloadData()
            }.catch { error in
                debugPrint(error)
            }
    }
}

// MARK: - UITableViewDataSource

extension LeaguesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: LeagueTableViewCell.identifier) as? LeagueTableViewCell {
            cell.update(league: viewModel.leagues[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.leagues.count
    }
}
