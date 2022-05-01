//
//  GameViewModel.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 01.05.2022.
//

import Foundation

protocol GameViewModelProtocol {
    var gameDescription: String { get }
    init(game: Game)
}

class GameViewModel: GameViewModelProtocol {
    var gameDescription: String {
        game.descriptionRaw ?? "No game description"
    }
    
    private let game: Game
    
    required init(game: Game) {
        self.game = game
    }
}
