//
//  GamesCollectionViewController.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 09.02.2022.
//

import UIKit

class GamesCollectionViewController: UICollectionViewController {
    
    private var superheroes: [Superhero] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSuperheroes(from: Links.superheoesUrl.rawValue)
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return superheroes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "game", for: indexPath) as! SuperheroCollectionViewCell
        
        let superheroe = superheroes[indexPath.item]
        cell.configureItem(with: superheroe)
        
        return cell
    }
    
    // MARK: - Private methods
    private func fetchGames(from url: String) {
        NetworkManager.shared.fetch(dataType: Superhero.self, from: url) { result in
            switch result {
            case .success(let gamesResponse):
//                superheroes = gamesResponse
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchSuperheroes(from url: String) {
        NetworkManager.shared.fetch(dataType: [Superhero].self, from: url) { result in
            switch result {
            case .success(let gamesResponse):
                self.superheroes = gamesResponse
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
