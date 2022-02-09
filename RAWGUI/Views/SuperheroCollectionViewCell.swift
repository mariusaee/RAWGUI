//
//  SuperheroCollectionViewCell.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 09.02.2022.
//

import UIKit

class SuperheroCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var gameImage: UIImageView!
    @IBOutlet var gameNameLabel: UILabel!
    
    func configureItem(with superhero: Superhero) {
        gameNameLabel.text = superhero.name
        
        DispatchQueue.global().async {
            guard let imageString = superhero.images?.md else { return }
            guard let imageURL = URL(string: imageString) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                self.gameImage.layer.cornerRadius = 15
                self.gameImage.image = UIImage(data: imageData)
            }
        }
    }
}
