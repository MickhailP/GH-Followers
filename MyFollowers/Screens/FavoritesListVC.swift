//
//  FavoritesListVC.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 14.03.2023.
//

import UIKit

class FavoritesListVC: GFDataLoadingVC {

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
		tableView.removeExcessCells()
	}


	func getFavorites() {
		PersistenceManager.retrieveFavorites { [weak self] result  in
			switch result {
				case .success(let favorites):
					guard let self = self else { return }
					self.updateUI(with: favorites)
				case .failure(_):
					self?.presentGFAlertOnMainTread(title: "Something went wrong", message: "Favorites is empty", buttonTitle: "Ok")
			}
		}
	}


	private func updateUI(with favorites: [Follower]) {
		if favorites.isEmpty {
			showEmptyStateView(with: "No favorites", in: self.view)
		} else {
			self.favorites = favorites
			DispatchQueue.main.async {
				self.tableView.reloadData()
				self.view.bringSubviewToFront(self.tableView)
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

		let destVC = FollowerListVC(userName: favorite.login)

		navigationController?.pushViewController(destVC, animated: true)
	}


	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else { return }

		PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
			guard let error else  {
				self?.favorites.remove(at: indexPath.row)
				self?.tableView.deleteRows(at: [indexPath], with: .right)
				return
			}
			self?.presentGFAlertOnMainTread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
		}
	}
}
