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
    
    private var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        fetch(from: LinksManager.shared.gameURL)
    }
    
    private func fetchTheGame(from url: String?) {
        NetworkManager.shared.fetchData(from: url) { [self] game in
            self.game = game
            guard let imageString = game.background_image else { return }
            guard let imageUrl = URL(string: imageString) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            backgroundImage.image = UIImage(data: imageData)
            gameNameLabel.text = game.name
            aboutGameTextView.text = game.description_raw
        }
    }
    
    private func fetchTheGameWithResult(from url: String) {
        NetworkManager.shared.fetchDataWithResult(from: url) { [self] result in
            switch result {
            case .success(let game):
                self.game = game
                guard let imageData = ImageManager.shared.fetchImage(from: game.background_image) else { return }
                backgroundImage.image = UIImage(data: imageData)
                gameNameLabel.text = game.name
                aboutGameTextView.text = game.description_raw
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetch(from url: String) {
        NetworkManager.shared.fetch(dataType: Game.self, from: url) { [self] result in
            switch result {
            case .success(let game):
                self.game = game
                guard let imageData = ImageManager.shared.fetchImage(from: game.background_image) else { return }
                backgroundImage.image = UIImage(data: imageData)
                gameNameLabel.text = game.name
                aboutGameTextView.text = game.description_raw
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

