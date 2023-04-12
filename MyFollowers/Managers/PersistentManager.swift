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

final class PersistenceManager{
	static private let defaults = UserDefaults.standard
	
	enum SaveKeys {
		static let favorites = "favorites"
	}
	
	
	static func updateWith(favorite: Follower, actionType: PersistenceActionType, completion: @escaping (ErrorMessage?) -> Void) {
		retrieveFavorites { result in
			switch result {
				case .success(var favorites):

					switch actionType {
						case .add:
							guard !favorites.contains(favorite) else {
								completion(.alreadySaved)
								return
							}
							favorites.append(favorite)
						case .remove:
							favorites.removeAll { $0.login == favorite.login }
					}
					
					completion(save(favourites: favorites))
					
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
