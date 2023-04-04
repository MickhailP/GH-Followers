//
//  GFFollowersItemVC.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 02.04.2023.
//

import UIKit

final class GFFollowersItemVC: GFItemInfoVC {
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureItems()
	}
	
	
	private func configureItems() {
		if let user {
			itemInfoOne.set(itemInfoType: .followers, with: user.followers)
			itemInfoTwo.set(itemInfoType: .following, with: user.following)
			actionButton.set(backgroundColor: .systemGreen, title: "Get followers")
		}
	}
	
	
	override func actionButtonTapped() {
		if let user {
			delegate?.didTapGetFollowers(for: user)
		}
	}
}
