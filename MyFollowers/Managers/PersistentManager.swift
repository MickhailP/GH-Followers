//
//  PersistentManager.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 03.04.2023.
//

import Foundation

enum PersistenceActionType {
	case add, remove
}

enum PersistenceManager{
	static private let defaults = UserDefaults.standard
	
	enum SaveKeys {
		static let favorites = "favorites"
	}
	
	
	static func updateWith(favorite: Follower, actionType: PersistenceActionType, completion: @escaping (ErrorMessage?) -> Void) {
		retrieveFavorites { result in
			switch result {
				case .success(let favorites):
					var retrievedFollowers = favorites
					
					switch actionType {
						case .add:
							guard !retrievedFollowers.contains(favorite) else {
								completion(.alreadySaved)
								return
							}
							retrievedFollowers.append(favorite)
						case .remove:
							retrievedFollowers.removeAll { $0.login == favorite.login }
					}
					
					completion(save(favourites: retrievedFollowers))
					
				case .failure:
					completion(.unableFavourites)
			}
		}
	}
	
	
	static func retrieveFavorites(completion: @escaping (Result<[Follower], ErrorMessage>) -> Void) {
		guard let favorites = defaults.data(forKey: SaveKeys.favorites) else {
			completion(.success([]))
			return
		}
		
		do {
			let followers = try JSONDecoder().decode([Follower].self, from: favorites)
			completion(.success(followers))
		} catch {
			completion(.failure(.invalidData))
		}
	}
	
	
	static private func save(favourites: [Follower]) -> ErrorMessage? {
		do {
			let encoded = try JSONEncoder().encode(favourites)
			defaults.set(encoded, forKey: SaveKeys.favorites)
			return nil
		} catch {
			return .unableFavourites
		}
	}
}
