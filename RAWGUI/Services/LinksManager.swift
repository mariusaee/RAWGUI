//
//  LinksManager.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 07.02.2022.
//

class LinksManager {
    static let shared = LinksManager()
    
    private init() {}
    
    private let apiKey = "e29e1df3581e4b07b4b7ea370b4cda67"
    private let randomGameID = Int.random(in: 1...22519)
    private let linkToID = "https://api.rawg.io/api/games/"
    
    var gameURL: String {
        "\(linkToID)\(randomGameID)?key=\(apiKey)"
    }
}


