//
//  NetworkManager.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 07.02.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum ResizeResolution: String {
    case size200 = "200"
    case size640 = "640"
    case size1280 = "1280"
    case size1920 = "1920"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(dataType: T.Type, from url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: URL, with resizeResolution: ResizeResolution, completion: @escaping(Data, URLResponse) -> Void) {
        let stringUrl = url.path
        let resizedImageString = stringUrl.replacingOccurrences(
            of: "media/games",
            with: "media/resize/\(resizeResolution.rawValue)/-/games"
        )
        
        guard let imageURL = URL(string: resizedImageString) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error localized description")
                return
            }
            
            guard imageURL == response.url else { return }
            
            DispatchQueue.main.async {
                completion(data, response)
            }
            
        }.resume()
    }
}
