//
//  GameViewController.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 03.02.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var gameNameLabel: UILabel!
    @IBOutlet var aboutGameTextView: UITextView!
    
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        guard let gameID = game?.id else { return }
        let url = "https://api.rawg.io/api/games/\(gameID)?key=e29e1df3581e4b07b4b7ea370b4cda67"
        fetchGame(from: url)
    }

    private func fetchGame(from url: String) {
        NetworkManager.shared.fetch(dataType: Game.self, from: url) { [self] result in
            switch result {
            case .success(let game):
                self.game = game
                guard let imageData = ImageManager.shared.fetchImage(from: game.backgroundImage) else { return }
                backgroundImage.image = UIImage(data: imageData)
                gameNameLabel.text = game.name
                aboutGameTextView.text = game.descriptionRaw
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureBackgroundView() {
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = backgroundImage.bounds
        gradientMaskLayer.colors = [UIColor.white.cgColor,
                                    UIColor.clear.cgColor]
        gradientMaskLayer.locations = [0, 1]
        backgroundImage.layer.mask = gradientMaskLayer
        backgroundImage.layer.cornerRadius = 20
    }
}

