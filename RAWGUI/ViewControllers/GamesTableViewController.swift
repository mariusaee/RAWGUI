//
//  GamesTableViewController.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 11.04.2022.
//

import UIKit

class GamesTableViewController: UITableViewController {
    
    //MARK: Private properties
    private var rawg: Rawg?
    private var games: [Game] = []
    private var timer: Timer?
    private let searchController = UISearchController()
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupNavigationBar()
        setupSearchController()
        fetchGames(from: Link.allGames.rawValue)
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
    
    private func fetchGames(from url: String) {
        NetworkManager.shared.fetch(dataType: Rawg.self, from: url) { result in
            switch result {
            case .success(let rawg):
                DispatchQueue.main.async {
                    self.rawg = rawg
                    self.games += rawg.results
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gameVC = segue.destination as? GameViewController else { return }
        
        guard let indexPaths = tableView.indexPathsForSelectedRows else { return }
        guard let selectedGameIndex = indexPaths.first?.item else { return }
        let game = games[selectedGameIndex]
        
        gameVC.game = game
    }
}

// MARK: - Table view data source methods
extension GamesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = games[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = games.count - 2
        
        if indexPath.item == lastElement {
            guard let url = rawg?.next else { return }
            fetchGames(from: url)
        }
    }
}

// MARK: - UISearchBarDelegate methods
extension GamesTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        games = []
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.fetchGames(from: Link.search.rawValue + searchText.replacingOccurrences(of: " ", with: "+"))
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        games = []
        fetchGames(from: Link.allGames.rawValue)
    }
}
