//
//  GameViewModel.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 01.05.2022.
//

import Foundation

protocol GameViewModelProtocol {
    var gameName: String { get }
//    var gameDescription: String { get }
    var imageData: Data? { get }
    init(game: Game)
}

class GameViewModel: GameViewModelProtocol {
    var gameName: String {
        game.name ?? "No game name"
    }
    
//    var gameDescription: String {
//        game.descriptionRaw ?? "No game description"
//    }
    
    var imageData: Data? {
        print("ImageData works")
        return ImageDataManager.shared.fetchImageData(from: URL(string: game.resizedImage))
    }
    
    private let game: Game
    
    required init(game: Game) {
        self.game = game
    }
}
