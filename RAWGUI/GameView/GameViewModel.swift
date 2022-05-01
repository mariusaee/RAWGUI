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


