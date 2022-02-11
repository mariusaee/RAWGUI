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
        
        if let cachedImage = getCachedImage(from: url) {
            image = cachedImage
            return
        }
        
        ImageManager.shared.fetchImage(from: url) { data, response in
            self.image = UIImage(data: data )
            self.saveDataToCache(data: data, and: response)
        }
    }
    private func saveDataToCache(data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let urlRequest = URLRequest(url: url)
        let cachedUrlResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedUrlResponse, for: urlRequest)
        print("IMAGE SAVED")
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            print("IMAGE GOTED with URL: \(url)")
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}
