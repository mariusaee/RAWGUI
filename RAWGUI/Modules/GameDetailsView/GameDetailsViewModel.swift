//
//  GameDetailsViewModel.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 01.05.2022.
//

import Foundation

protocol GameDetailsViewModelProtocol {
    var gameName: String { get }
    var gameUrl: String { get }
    var gameDescription: String { get }
    var resizedImageUrl: URL? { get }
    var imageData: Data? { get }
    
    init(game: Game)
}

class GameDetailsViewModel: GameDetailsViewModelProtocol {
    
    var gameName: String {
        game.name ?? "No game name"
    }
    
    var gameUrl: String {
        "\(Link.game.rawValue)\(game.id)?key=e29e1df3581e4b07b4b7ea370b4cda67"
    }
    
    var gameDescription: String {
        // TODO: should return game.descriptionRaw from the gameUrl
        "gameDescription"
    }
    
    var resizedImageUrl: URL? {
        let resizedImageUrl = game.backgroundImage?.replacingOccurrences(
            of: "media/games", with: "media/resize/640/-/games"
        ) ?? "--"
        return URL(string: resizedImageUrl)
    }
    
    var imageData: Data? {
        ImageDataManager.shared.fetchImageData(from: resizedImageUrl)
    }
    
    private let game: Game
    
    required init(game: Game) {
        self.game = game
    }
}
