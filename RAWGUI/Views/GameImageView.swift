//
//  GameImageView.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 11.02.2022.
//

import UIKit

class GameImageView: UIImageView {
    func fetchImage(from url: String) {
        guard let url = URL(string: url) else {
            image = UIImage(named: "defaultBackgroundImage")
            return
        }
    }
}
