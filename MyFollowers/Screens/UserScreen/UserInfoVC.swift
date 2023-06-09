//
//  UserInfoVC.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 23.03.2023.
//

import UIKit
import SnapKit


protocol UserInfoVCDelegate: AnyObject {
	func requestFollowers(for username: String)
}


typealias ItemInfoVCDelegates = FollowersInfoVCDelegate & RepoInfoVCDelegate


//MARK: ViewController
class UserInfoVC: GFDataLoadingVC {
	
	var userName: String?

	let scrollView = UIScrollView()
	let contentView = UIView()

	var itemViews: [UIView] = []
	let userInfoHeader = UIView()
	let itemViewOne = UIView()
	let itemViewTwo = UIView()
	
	let dateLabel = GFBodyLabel(textAlignment: .center)
	
	weak var delegate: UserInfoVCDelegate?

	var userInfoHeaderHeightConstraint: NSLayoutConstraint?


	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureVC()
		configureScrollVIew()
		layoutUI()
		
		if let userName {
			getUser(userName)
		}
	}


	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
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
		//		showLoadingView()
		
		NetworkManager.shared.getUser(for: name) { [weak self] result in
			guard let self = self else {
				self?.dismissLoadingView()
				return
			}
			
			//			self.dismissLoadingView()
			
			switch result {
				case .success(let user):
					DispatchQueue.main.async {
						self.configureUIElements(with: user)
					}
					
				case .failure(_):
					DispatchQueue.main.async{
						self.showEmptyStateView(with: "Seems there was an error during fetching data from the internet.", in: self.view)
					}
			}
		}
	}
	
	
	private func configureUIElements(with user: User) {
		
		let repoItemVC = GFRepoItemVC(user: user, delegate: self)
		let followerItemVC = GFFollowersItemVC(user: user, delegate: self)

		let userSectionVC = GFUserInfoHeaderVC(user: user)

		add(childVC: userSectionVC, to: userInfoHeader)
		add(childVC: repoItemVC, to: itemViewOne)
		add(childVC: followerItemVC, to: itemViewTwo)

		userSectionVC.view.layoutIfNeeded()
		userInfoHeaderHeightConstraint?.constant = userSectionVC.contentHeight

		userSectionVC.view.layoutIfNeeded()

		let newFormatter = ISO8601DateFormatter()
		if let date = newFormatter.date(from: user.createdAt) {
			dateLabel.text = "Joined \(date.convertToMontYearFormat())"
		}
	}

	
	private func layoutUI() {
		let padding: CGFloat = 20
		let itemHeight: CGFloat = 180
		
		itemViews = [userInfoHeader, itemViewOne, itemViewTwo, dateLabel]

		itemViews.forEach{
			contentView.addSubview($0)

			$0.translatesAutoresizingMaskIntoConstraints = false
			
			if $0 != dateLabel, $0 != userInfoHeader {
				$0.snp.makeConstraints { make in
					make.leading.trailing.equalTo(contentView).inset(padding)
					make.height.equalTo(itemHeight)
				}
			}
		}

		userInfoHeader.snp.makeConstraints { make in
			make.top.equalTo(contentView.safeAreaLayoutGuide).inset(padding)
			make.leading.trailing.equalTo(contentView).inset(padding)

			userInfoHeaderHeightConstraint =
			make.height.greaterThanOrEqualTo(160).constraint.layoutConstraints[0]
		}
		
		itemViewOne.snp.makeConstraints { make in
			make.top.equalTo(userInfoHeader.snp.bottom).offset(padding)
		}
		
		itemViewTwo.snp.makeConstraints { make in
			make.top.equalTo(itemViewOne.snp.bottom).offset(padding)
		}
		
		dateLabel.snp.makeConstraints { make in
			make.leading.trailing.equalTo(contentView).inset(padding)
			make.top.equalTo(itemViewTwo.snp.bottom).offset(padding)
			make.height.equalTo(50)
		}
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
	}


	private func add(childVC: UIViewController, to containerView: UIView) {
		addChild(childVC)
		containerView.addSubview(childVC.view)
		print(#function, "FRAME SETS")
		childVC.view.frame = containerView.bounds
		childVC.didMove(toParent: self)
		containerView.layer.cornerRadius = 10
		containerView.layer.masksToBounds = true
	}


	private func configureScrollVIew() {
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)

		scrollView.pinToEdges(of: view)
		contentView.pinToEdges(of: scrollView)
		contentView.snp.makeConstraints { make in
			make.width.equalToSuperview()
			make.height.equalTo(1000)
		}
	}
}


//MARK: ItemInfoVCDelegates
extension UserInfoVC: ItemInfoVCDelegates {
	
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

