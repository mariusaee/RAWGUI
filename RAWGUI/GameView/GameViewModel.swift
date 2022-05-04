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

    var resizedImageUrl: URL? { get }
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
    
    var resizedImageUrl: URL? {
        let resizedImageUrl = game.backgroundImage.replacingOccurrences(
            of: "media/games", with: "media/resize/640/-/games"
        )
        return URL(string: resizedImageUrl)
    }
    
    var imageData: Data? {
        return ImageDataManager.shared.fetchImageData(from: resizedImageUrl)
    }
    
    private let game: Game
    
    required init(game: Game) {
        self.game = game
    }
}
