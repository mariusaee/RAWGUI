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
//        imageView.contentMode = .scaleAspectFit
        imageView.frame.size.height = 10
        imageView.frame.size.width = 10

        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = game?.name
        view.addSubview(gameImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            gameImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            gameImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
