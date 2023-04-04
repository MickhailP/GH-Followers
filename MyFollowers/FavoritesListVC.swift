//
//  FavoritesListVC.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 14.03.2023.
//

import UIKit

class FavoritesListVC: UIViewController {
	
	let tableView = UITableView()
	var favorites: [Follower] = []
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureViewController()
		configureTableView()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		getFavorites()
	}
	
	
	func configureViewController() {
		view.backgroundColor = .systemBackground
		title = "Favorites"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	
	private func configureTableView() {
		view.addSubview(tableView)
		tableView.frame = view.bounds
		tableView.rowHeight = 80
		tableView.register(FavoriteCell.self, forCellReuseIdentifier: Constants.CellsNames.favoriteCell)
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	
	func getFavorites() {
		PersistenceManager.retrieveFavorites { [weak self] result  in
			switch result {
				case .success(let success):
					guard let self = self else { return }
					
					if success.isEmpty {
						print("EMPTY")
						self.showEmptyStateView(with: "No favorites", in: self.view)
					} else {
						self.favorites = success
						print(self.favorites)
						DispatchQueue.main.async {
							self.tableView.reloadData()
							self.view.bringSubviewToFront(self.tableView)
						}
					}
					
				case .failure(let failure):
					self?.presentGFAlertOnMainTread(title: "Something went wrong", message: "Favorites is empty", buttonTitle: "Ok")
			}
		}
	}
}


extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		favorites.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellsNames.favoriteCell) as! FavoriteCell
		let favorite = favorites[indexPath.row]
		cell.set(favorite: favorite)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let favorite = favorites[indexPath.row]
		
		let destVC = FollowerListVC()
		destVC.userName = favorite.login
		destVC.title = favorite.login
		
		navigationController?.pushViewController(destVC, animated: true)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		
		guard editingStyle == .delete else { return }
		
		let favorite = favorites[indexPath.row]
		favorites.remove(at: indexPath.row)
		tableView.deleteRows(at: [indexPath], with: .right)
		
		PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
			guard let error else  { return }
			self?.presentGFAlertOnMainTread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
		}
		
	}
}
