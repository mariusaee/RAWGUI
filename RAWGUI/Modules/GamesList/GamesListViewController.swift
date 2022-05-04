//
//  GamesListViewController.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 11.04.2022.
//

import UIKit

class GamesListViewController: UITableViewController {
    
    //MARK: - Properties
    private var rawg: Rawg?
//    private var games: [Game] = []
    private var timer: Timer?
    private let searchController = UISearchController()
    var gamesListViewModel: GamesListViewModelProtocol! {
        didSet {
            gamesListViewModel.fetchGames {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        gamesListViewModel = GamesListViewModel()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupNavigationBar()
        setupSearchController()
//        fetchGames(from: Link.allGames.rawValue)
    }
    
    // MARK: - Private methods
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
    
//    private func fetchGames(from url: String) {
//        NetworkManager.shared.fetch(dataType: Rawg.self, from: url) { result in
//            switch result {
//            case .success(let rawg):
//                self.rawg = rawg
//                self.games += rawg.results
//                self.tableView.reloadData()
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}

// MARK: - Table view data source methods
extension GamesListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gamesListViewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = "ss" //games[indexPath.row].name
        
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let lastElement = games.count - 2
//
//        if indexPath.item == lastElement {
//            guard let url = rawg?.next else { return }
//            fetchGames(from: url)
//        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let gameVC = GameDetailsViewController()
//        gameVC.game = games[indexPath.row]
//        navigationController?.pushViewController(gameVC, animated: true)
    }
    
}

// MARK: - UISearchBarDelegate methods
extension GamesListViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        games = []
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
//            self.fetchGames(from: Link.search.rawValue + searchText.replacingOccurrences(of: " ", with: "+"))
//        }
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        games = []
//        fetchGames(from: Link.allGames.rawValue)
//    }
}