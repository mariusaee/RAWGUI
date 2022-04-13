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
    
    private lazy var gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "defaultBackgroundImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.sizeToFit()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.text = "Hi! In this tutorial, we will learn how to create a UIScrollView programmatically that contains two UILabel and adapt its size based on the size of the views that it contains.In this tutorial, we will learn how to create a UIScrollView programmatically that contains two UILabel and adapt its size based on the size of the views that it contains.In this tutorial, we will learn how to create a UIScrollView programmatically that contains two UILabel and adapt its size based on the size of the views that it contains.In this tutorial, we will learn how to create a UIScrollView programmatically that contains two UILabel and adapt its size based on the size of the views that it contains.In this tutorial, we will learn how to create a UIScrollView programmatically that contains two UILabel and adapt its size based on the size of the views that it contains.In this tutorial, we will learn how to create a UIScrollView programmatically that contains two UILabel and adapt its size based on the size of the views that it contains.In this tutorial, we will learn how to create a UIScrollView programmatically that contains two UILabel and adapt its size based on the size of the views that it contains.Hi! In this tutorial, we will learn how to create a UIScrollView programmatically that contains two UILabel and adapt its size based on the size of the views that it contains.In this tutorial, we will learn how to create a UIScrollView programmatically that contains two UILabel and adapt its size based on the size of the views that it contains.In this tutorial, we will learn how to create a UIScrollView programmatically that contains two UILabel and adapt its size based on the size of the views that it contains.In this tutorial, we will learn how to create a UIScrollView programmatically that contains two UILabel and adapt its size based on the size of the views that it contains.In this tutorial, we will learn how to create a UIScrollView programmatically that contains two UILabel and adapt its size based on the size of the views that it contains.In this tutorial, we will learn how to create a UIScrollView programmatically that contains two UILabel and adapt its size based on the size of the views that it contains.In this tutorial, we will learn how to create a UIScrollView programmatically that contains two UILabel and adapt its size based on the size of the views that it contains."
        return descriptionLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = game?.name
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(gameImageView)
        contentView.addSubview(descriptionLabel)
        
        setupConstraints()
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
