//
//  GFTabBarController.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 04.04.2023.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		viewControllers = [createSearchNC(), createFavoritesNC()]
		
		let tabBarAppearance = UITabBarAppearance()
		tabBarAppearance.configureWithOpaqueBackground()
		UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
		UITabBar.appearance().tintColor = .systemGreen
    }
	
	
	func createSearchNC() -> UINavigationController {
		let searchVC = SearchVC()
		searchVC.title = "Search"
		searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
		return UINavigationController(rootViewController: searchVC)
	}
	
	
	func createFavoritesNC() -> UINavigationController {
		let favoritesNC = FavoritesListVC()
		favoritesNC.title = "Favorites"
		favoritesNC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
		return UINavigationController(rootViewController: favoritesNC)
	}
}
