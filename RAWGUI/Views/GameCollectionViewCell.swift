//
//  GameCollectionViewCell.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 09.02.2022.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var gameImage: GameImageView!
    @IBOutlet var gameNameLabel: UILabel!
    
    func configureItem(with game: Game) {
        gameNameLabel.text = game.name
        gameImage.fetchImage(from: game.newImage)
    }
}

