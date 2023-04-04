//
//  UserInfoVC.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 23.03.2023.
//

import UIKit
import SnapKit


//MARK: Delegate Protocol
protocol UserInfoVCDelegate: AnyObject {
	func didTapGitHubProfile(for user: User)
	func didTapGetFollowers(for user: User)
}


//MARK: ViewController
class UserInfoVC: UIViewController {
	
	var userName: String?
	
	var itemViews: [UIView] = []
	let userInfoHeader = UIView()
	let itemViewOne = UIView()
	let itemViewTwo = UIView()
	
	let dateLabel = GFBodyLabel(textAlignment: .center)
	
	weak var delegate: FollowerListVCDelegate?
	

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
						self.configureUIElements(with: user)
					}
					
				case .failure(let error):
					self.presentGFAlertOnMainTread(title: "Something went wrong", message: "Try again later", buttonTitle: "Ok")
			}
		}
	}
	
	private func configureUIElements(with user: User) {
		
		let repoItemVC = GFRepoItemVC(user: user)
		repoItemVC.delegate = self
		
		let followerItemVC = GFFollowersItemVC(user: user)
		followerItemVC.delegate = self
		
		add(childVC: GFUserInfoHeaderVC(user: user), to: userInfoHeader)
		add(childVC: repoItemVC, to: itemViewOne)
		add(childVC: followerItemVC, to: itemViewTwo)
		
		dateLabel.text = "Joined \(user.createdAt.convertToDisplayFormat())"
	}

	
	private func layoutUI() {
		let padding: CGFloat = 20
		let itemHeight: CGFloat = 180
		
		itemViews = [userInfoHeader, itemViewOne, itemViewTwo, dateLabel]
		
		itemViews.forEach{
			view.addSubview($0)
			
			$0.translatesAutoresizingMaskIntoConstraints = false
			
			if $0 != dateLabel {
				$0.snp.makeConstraints { make in
					make.leading.trailing.equalTo(view).inset(padding)
					make.height.equalTo(itemHeight)
				}
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
		
		dateLabel.snp.makeConstraints { make in
			make.leading.trailing.equalTo(view).inset(padding)
			make.top.equalTo(itemViewTwo.snp.bottom).offset(padding)
			make.height.equalTo(18)
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


//MARK: UserInfoVCDelegate
extension UserInfoVC: UserInfoVCDelegate  {
	func didTapGitHubProfile(for user: User)  {
		// Show Safari VC
		guard let url = URL(string: user.htmlUrl) else {
			presentGFAlertOnMainTread(title: "Invalid URL", message: "The url is incorrect", buttonTitle: "Ok")
			return
		}
		
		presentSafariVC(with: url)
	}
	
	
	func didTapGetFollowers(for user: User) {
		guard user.followers != 0 else {
			presentGFAlertOnMainTread(title: "No followers", message: "This user doesn't have followers.", buttonTitle: "Ok")
			return
		}
		delegate?.requestFollowers(for: user.login)
		dismissView()
	}
}

