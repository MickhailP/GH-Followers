//
//  GFRepoItemVC.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 01.04.2023.
//

import UIKit

protocol RepoInfoVCDelegate: AnyObject {
	func didTapGitHubProfile(for user: User)
}


final class GFRepoItemVC: GFItemInfoVC {

	weak var delegate: RepoInfoVCDelegate?


	init(user: User, delegate: RepoInfoVCDelegate) {
		super.init(user: user)
		self.delegate = delegate
	}


	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	
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
	
	
	override func actionButtonTapped() {
		if let user {
			delegate?.didTapGitHubProfile(for: user)
		}
	}
}
