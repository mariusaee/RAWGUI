//
//  GamesCollectionViewController.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 09.02.2022.
//

import UIKit

class GamesCollectionViewController: UICollectionViewController {
    
    private var games: [Game] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGames(from: Link.randomGames.rawValue)
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
    
    // MARK: - Private methods
    private func fetchGames(from url: String) {
        NetworkManager.shared.fetch(dataType: Rawg.self, from: url) { result in
            switch result {
            case .success(let games):
                DispatchQueue.main.async {
                    self.games = games.results ?? []
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

