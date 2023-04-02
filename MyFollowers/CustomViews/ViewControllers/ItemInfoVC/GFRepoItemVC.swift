//
//  GFRepoItemVC.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 01.04.2023.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureItems()
	}
	
	private func configureItems() {
		if let user {
			itemInfoOne.set(itemInfoType: .repos, with: user.publicRepos)
			itemInfoTwo.set(itemInfoType: .gists, with: user.publicGists)
			actionButton.set(backgroundColor: .systemPurple, title: "GitHub profile")
		}
	}
}
