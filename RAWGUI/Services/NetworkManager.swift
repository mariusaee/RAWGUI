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

class ImageDataManager {
    static let shared = ImageDataManager()
    
    private init() {}
    
    func fetchImageData(from url: URL?, completion: @escaping(Data?) -> Void) {
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                completion(data)
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
                completion(nil)
            }
        }.resume()
    }
}
