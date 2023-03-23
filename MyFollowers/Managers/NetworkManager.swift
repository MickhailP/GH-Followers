//
//  NetworkManager.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 17.03.2023.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    static let cache = NSCache<NSString, UIImage>()
    
    private let baseURL = "http://api.github.com"
    
    
    private init() {
        
    }
    
    func getFollowers(for username: String, page: Int, completionHandler: @escaping (Result<[Follower], ErrorMessages>) -> Void) {
		
        let endpoint = baseURL + "/users/\(username)/followers?per_page=100&page=\(page)"
        print(endpoint)
        
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completionHandler(.failure(.invalidResponse))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedData = try JSONDecoder().decode([Follower].self, from: data)
                print(decodedData)
                completionHandler(.success(decodedData))
                
                
            } catch  {
                print(error)
                print(error.localizedDescription)
                completionHandler(.failure(.decodingError))
            }
           
        }
        task.resume()
    }
}
