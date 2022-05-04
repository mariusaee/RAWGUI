//
//  GamesListViewModel.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 04.05.2022.
//

import Foundation

protocol GamesListViewModelProtocol {
    var rawg: Rawg? { get }
    var games: [Game] { get }
    func fetchGames(completion: @escaping() -> Void)
    func numberOfRows() -> Int
}

class GamesListViewModel: GamesListViewModelProtocol {
    var rawg: Rawg?
    var games: [Game] = []
    
    func fetchGames(completion: @escaping () -> Void) {
        NetworkManager.shared.fetch(dataType: Rawg.self, from: Link.allGames.rawValue) { result in
            switch result {
            case .success(let rawg):
                self.rawg = rawg
                self.games += rawg.results
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRows() -> Int {
        games.count
    }
}
