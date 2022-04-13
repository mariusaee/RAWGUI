//
//  GameViewController.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 12.04.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    var game: Game?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var gameImageView: GameImageView = {
        let imageView = GameImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "defaultBackgroundImage")
        imageView.contentMode = .scaleAspectFit
        if let imageUrl = game?.newImage {
            imageView.fetchImage(from: imageUrl)
        }
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.sizeToFit()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.text = "text"
        if let gameID = game?.id {
            let url = "https://api.rawg.io/api/games/\(gameID)?key=e29e1df3581e4b07b4b7ea370b4cda67"
            fetchGame(from: url)
        }
        return descriptionLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = game?.name
        view.addSubview(scrollView)
        configureViews()
        setupConstraints()
    }
    
    private func fetchGame(from url: String) {
        NetworkManager.shared.fetch(dataType: Game.self, from: url) { [self] result in
            switch result {
            case .success(let game):
                self.game = game
                descriptionLabel.text = game.descriptionRaw
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureViews() {
        scrollView.addSubview(contentView)
        contentView.addSubview(gameImageView)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            gameImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            gameImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.43),
            
            descriptionLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
