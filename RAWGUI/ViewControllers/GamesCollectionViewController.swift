//
//  GamesCollectionViewController.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 09.02.2022.
//

import UIKit

class GamesCollectionViewController: UICollectionViewController {
    
    //MARK: Private properties
    private var rawg: Rawg?
    private var games: [Game] = []
    private var timer: Timer?
    private let searchController = UISearchController()
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGames(from: Link.allGames.rawValue)
        setupSearchController()
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "game", for: indexPath) as! GameCollectionViewCell
        
        let game = games[indexPath.item]
        cell.configureItem(with: game)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastElement = games.count - 2
        
        if indexPath.item == lastElement {
            guard let url = rawg?.next else { return }
            fetchGames(from: url)
            print("Bottom here")
            print(url)
        }
    }
    
    // MARK: - Private methods
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
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
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
        
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gameVC = segue.destination as? GameViewController else { return }
        
        guard let indexPaths = collectionView.indexPathsForSelectedItems else { return }
        guard let selectedGameIndex = indexPaths.first?.item else { return }
        let game = games[selectedGameIndex]
        
        gameVC.game = game
    }
}

extension GamesCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchedText = searchController.searchBar.text else { return }
        games = []
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.fetchGames(from: Link.search.rawValue + searchedText.replacingOccurrences(of: " ", with: "+"))
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        games = []
        fetchGames(from: Link.allGames.rawValue)
    }
}
