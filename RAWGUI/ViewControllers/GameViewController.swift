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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGame()
        configureBackgroundView()
    }
    
    private func fetchGame() {
        let urlString = "https://api.rawg.io/api/games/22511?key="
        let apiKey = "e29e1df3581e4b07b4b7ea370b4cda67"
        
        guard let url = URL(string: urlString + apiKey) else { return }
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }
            do {
                let game = try JSONDecoder().decode(Game.self, from: data)
                
                DispatchQueue.main.async {
                    guard let imageString = game.background_image else { return }
                    guard let imageUrl = URL(string: imageString) else { return }
                    guard let imageData = try? Data(contentsOf: imageUrl) else { return }
                    self.backgroundImage.image = UIImage(data: imageData)
                    self.gameNameLabel.text = game.name
                    self.aboutGameTextView.text = game.description_raw
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
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

