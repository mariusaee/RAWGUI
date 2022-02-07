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

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String?, with completion: @escaping(Game) -> Void) {
        guard let urlString = url else { return }
        guard let url = URL(string: urlString) else { return }
            
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No localized description")
                return
            }
            
            do {
                let game = try JSONDecoder().decode(Game.self, from: data)
                DispatchQueue.main.async {
                    completion(game)
                }
            } catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
    }
    
    func fetchDataWithResult(from url: String, with completion: @escaping(Result<Game, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let game = try JSONDecoder().decode(Game.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(game))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()

    }
}

