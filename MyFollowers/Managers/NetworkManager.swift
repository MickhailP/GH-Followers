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
	
	private let cache = NSCache<NSString, UIImage>()
	
	private let baseURL = "http://api.github.com"
	
	
	private init() {
		
	}
	
	
	func getFollowers(for username: String, page: Int, completionHandler: @escaping (Result<[Follower], ErrorMessage>) -> Void) {
		
		let endpoint = baseURL + "/users/\(username)/followers?per_page=100&page=\(page)"
		print(endpoint)
		
		guard let url = URL(string: endpoint) else {
			completionHandler(.failure(.invalidUsername))
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if error != nil {
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
				decoder.dateDecodingStrategy = .iso8601
				let decodedData = try JSONDecoder().decode([Follower].self, from: data)
				completionHandler(.success(decodedData))
				
				
			} catch  {
				print(error)
				print(error.localizedDescription)
				completionHandler(.failure(.decodingError))
			}
			
		}
		task.resume()
	}
	
	
	func getUser(for username: String, completionHandler: @escaping (Result<User, ErrorMessage>) -> Void) {
		
		let endpoint = baseURL + "/users/\(username)"
		print(endpoint)
		
		guard let url = URL(string: endpoint) else {
			completionHandler(.failure(.invalidUsername))
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if error != nil {
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
				let decodedUser = try JSONDecoder().decode(User.self, from: data)
				print(decodedUser)
				completionHandler(.success(decodedUser))
				
				
			} catch  {
				print(error)
				print(error.localizedDescription)
				completionHandler(.failure(.decodingError))
			}
			
		}
		task.resume()
	}
	
	func downloadImage(from url: String) async -> UIImage? {
		
		if let cachedImage = self.cache.object(forKey: NSString(string: url)) {
			return cachedImage
		} else if let fetchedImage = await fetchImage(from: url) {
			self.cache.setObject(fetchedImage, forKey: NSString(string: url))
			return fetchedImage
		}
		
		return nil
	}
	
	
	private func fetchImage(from urlString: String) async -> UIImage? {
		guard let url = URL(string: urlString) else   {
			return nil
		}
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			return UIImage(data: data)
		} catch  {
			print(error)
			return nil
		}
	}
}
