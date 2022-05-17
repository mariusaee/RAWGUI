//
//  GamesListViewModel.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 04.05.2022.
//

import Foundation

protocol GamesListViewModelProtocol {
    var rawg: Rawg? { get }
    var games: [Game] { get set }
    var game: Game? { get }
    func fetchGames(url: String, completion: @escaping() -> Void)
    func fetchGame(url: String, completion: @escaping() -> Void)
    func numberOfRows() -> Int
}

class GamesListViewModel: GamesListViewModelProtocol {
    var rawg: Rawg?
    var games: [Game] = []
    var game: Game?
    
    func fetchGames(url: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetch(dataType: Rawg.self, from: url) { result in
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
    
    func fetchGame(url: String, completion: @escaping() -> Void) {
        NetworkManager.shared.fetch(dataType: Game.self, from: url) { result in
            switch result {
            case .success(let fetchedGame):
                self.game = fetchedGame
                completion()
//                self.navigationController?.pushViewController(gameVC, animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfRows() -> Int {
        games.count
    }
}
