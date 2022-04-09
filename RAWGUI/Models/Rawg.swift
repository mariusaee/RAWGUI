//
//  Rawg.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 03.02.2022.
//

struct Rawg: Codable {
    let results: [Game]
    let next: String?
}

struct Game: Codable {
    let id: Int?
    let name: String?
    let descriptionRaw: String?
    let backgroundImage: String?
    var newImage: String {
        backgroundImage?.replacingOccurrences(
            of: "media/games", with: "media/resize/640/-/games"
        ) ?? "defaultBackgroundImage"
    }
}

enum Link: String {
    case zelda = "https://api.rawg.io/api/games/22511?key=e29e1df3581e4b07b4b7ea370b4cda67"
    case allGames = "https://api.rawg.io/api/games?key=e29e1df3581e4b07b4b7ea370b4cda67&page=1"
    case search = "https://api.rawg.io/api/games?key=e29e1df3581e4b07b4b7ea370b4cda67&search="
}
