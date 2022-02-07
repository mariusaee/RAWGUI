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
        fetchTheGame(from: LinksManager.shared.gameURL)
    }
    
    private func fetchTheGame(from url: String?) {
        NetworkManager.shared.fetchData(from: url) { game in
            self.game = game
            DispatchQueue.main.async {
                guard let imageString = game.background_image else { return }
                guard let imageUrl = URL(string: imageString) else { return }
                guard let imageData = try? Data(contentsOf: imageUrl) else { return }
                self.backgroundImage.image = UIImage(data: imageData)
                self.gameNameLabel.text = game.name
                self.aboutGameTextView.text = game.description_raw
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

