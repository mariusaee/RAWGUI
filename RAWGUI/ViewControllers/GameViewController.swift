//
//  GameViewController.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 12.04.2022.
//

import UIKit

class GameViewController: UIViewController {

    var game: Game?
    
    private lazy var gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "defaultBackgroundImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = game?.name
        view.addSubview(gameImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            gameImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            gameImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30)
        ])
    }
}
