//
//  UserInfoVC.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 23.03.2023.
//

import UIKit
import SnapKit

class UserInfoVC: UIViewController {
	
	var userName: String?
	var itemViews: [UIView] = []
	var userInfoHeader = UIView()
	var itemViewOne = UIView()
	var itemViewTwo = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		configureVC()
		
		if let userName {
			getUser(userName)
		}
		
		layoutUI()
	}
    
	@objc func dismissView() {
		dismiss(animated: true)
	}
	
	private func configureVC() {
		view.backgroundColor = .systemBackground
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissView))
		navigationItem.rightBarButtonItem = doneButton
	}
	
	private func getUser(_ name: String) {
		NetworkManager.shared.getUser(for: name) { [weak self] result in
			guard let self = self else { return }
			
			switch result {
				case .success(let user):
					DispatchQueue.main.async {
						self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.userInfoHeader)
					}
				case .failure(let error):
					self.presentGFAlertOnMainTread(title: "Something went wrong", message: "Try again later", buttonTitle: "Ok")
			}
		}
	}
	
	private func layoutUI() {
		let padding: CGFloat = 20
		let itemHeight: CGFloat = 180
		
		itemViews = [userInfoHeader, itemViewOne, itemViewTwo]
		
		itemViews.forEach{
			view.addSubview($0)
			
			$0.translatesAutoresizingMaskIntoConstraints = false
			
			$0.snp.makeConstraints { make in
				make.leading.trailing.equalTo(view).inset(padding)
				make.height.equalTo(itemHeight)
			}
		}
				
		userInfoHeader.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).inset(padding)
		}
		
		itemViewOne.snp.makeConstraints { make in
			make.top.equalTo(userInfoHeader.snp.bottom).offset(padding)
		}
		
		itemViewTwo.snp.makeConstraints { make in
			make.top.equalTo(itemViewOne.snp.bottom).offset(padding)
		}
	}
	

	private func add(childVC: UIViewController, to containerView: UIView) {
		addChild(childVC)
		containerView.addSubview(childVC.view)
		childVC.view.frame = containerView.bounds
		childVC.didMove(toParent: self)
		containerView.layer.cornerRadius = 10
		containerView.layer.masksToBounds = true
	}
}
