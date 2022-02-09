//
//  GameCollectionViewCell.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 09.02.2022.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var gameImage: UIImageView!
    @IBOutlet var gameNameLabel: UILabel!
    
    func configureItem(with game: Game) {
        gameNameLabel.text = game.name
        
        DispatchQueue.global().async {
            guard let imageString = game.backgroundImage else { return }
            guard let imageURL = URL(string: imageString) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                self.gameImage.layer.cornerRadius = 15
                self.gameImage.image = UIImage(data: imageData)
            }
        }
    }
}
