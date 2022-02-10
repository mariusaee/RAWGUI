//
//  Rawg.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 03.02.2022.
//

struct Rawg: Codable {
    let results: [Game]?
}

struct Game: Codable {
    let id: Int?
    let name: String?
    let descriptionRaw: String?
    let backgroundImage: String?
}

enum Link: String {
    case randomGame = "https://api.rawg.io/api/games/22511?key=e29e1df3581e4b07b4b7ea370b4cda67"
    case randomGames = "https://api.rawg.io/api/games?key=e29e1df3581e4b07b4b7ea370b4cda67"
}
