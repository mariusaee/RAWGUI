//
//  GamesListViewController.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 11.04.2022.
//

import UIKit

class GamesListViewController: UIViewController {
    
    //MARK: - Properties
    private let tableView = UITableView()
    private var timer: Timer?
    private let searchController = UISearchController()
    private var gamesListViewModel: GamesListViewModelProtocol!
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        gamesListViewModel = GamesListViewModel()
        setupTableView()
        setupNavigationBar()
        setupSearchController()
        gamesListViewModel.fetchGames(url: Link.allGames.rawValue) {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Private methods
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
    
    private func setupNavigationBar() {
        title = "Games"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search games"
        definesPresentationContext = true
    }
}

// MARK: - Table view data source methods
extension GamesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gamesListViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = gamesListViewModel.games[indexPath.row].name
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = gamesListViewModel.games.count - 2
        if indexPath.item == lastElement {
            guard let url = gamesListViewModel.rawg?.next else { return }
            gamesListViewModel.fetchGames(url: url) {
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let gameVC = GameDetailsViewController()
        
        let gameID = gamesListViewModel.games[indexPath.row].id
        let url = "\(Link.game.rawValue)\(gameID)?key=e29e1df3581e4b07b4b7ea370b4cda67"
        
        gamesListViewModel.fetchGame(url: url) {
            gameVC.game = self.gamesListViewModel.game
            self.navigationController?.pushViewController(gameVC, animated: true)
        }
    }
}

// MARK: - UISearchBarDelegate methods
extension GamesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.gamesListViewModel.games.removeAll()
        let url = Link.search.rawValue + searchText.replacingOccurrences(of: " ", with: "+")
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.gamesListViewModel.fetchGames(url: url) {
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        gamesListViewModel.games.removeAll()
        gamesListViewModel.fetchGames(url: Link.allGames.rawValue) {
            self.tableView.reloadData()
        }
    }
}
