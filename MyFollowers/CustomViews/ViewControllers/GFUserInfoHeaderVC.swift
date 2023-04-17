//
//  GFUserInfoHeaderVC.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 27.03.2023.
//

import UIKit
import SnapKit

final class GFUserInfoHeaderVC: UIViewController {

	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: Constants.FontSizes.header1)
	let nameLabel = GFSecondaryTitleLabel(fontSize: Constants.FontSizes.header2)
	let locationImageView = UIImageView()
	let locationLabel = GFSecondaryTitleLabel(fontSize: Constants.FontSizes.header2)
	let bioLabel = GFBodyLabel(textAlignment: .left)

	var user: User?

	let padding: CGFloat = 20
	let lineGap: CGFloat = 5

	var bioLabelHeightConstraint: NSLayoutConstraint?

	var contentHeight: CGFloat {
		avatarImageView.frame.height + bioLabel.intrinsicContentSize.height + padding * 3
	}


	init(user: User) {
		super.init(nibName: nil, bundle: nil)
		self.user = user
	}

	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .secondarySystemBackground
        addSubviews()
		layoutUI()
    }


	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		configureUIElements()
	}


	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
	}

	
	private func configureUIElements() {
		guard let user else {
			self.presentGFAlertOnMainTread(title: "Error", message: "User doesn't available.", buttonTitle: "Ok")
			return
		}
		avatarImageView.getImage(from: user.avatarUrl)
		usernameLabel.text = user.login
		nameLabel.text = user.name ?? "NA"
		locationLabel.text = user.location ?? "No location"

		bioLabel.text = user.bio ?? "No bio available"
		bioLabelHeightConstraint?.constant = bioLabel.intrinsicContentSize.height + 5
		view.layoutIfNeeded()

		locationImageView.image = UIImage(systemName: Constants.Images.location)
		locationImageView.tintColor = .secondaryLabel
	}
	
	
	private func addSubviews() {
		let views = [avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, bioLabel]
		views.forEach {
			view.addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
	}

	
	private func layoutUI() {

		let textImagePadding: CGFloat = 12

		avatarImageView.snp.makeConstraints { make in
			make.top.equalTo(view).inset(padding)
			make.leading.equalTo(view).inset(padding)
			make.width.height.equalTo(90)
		}
		
		usernameLabel.snp.makeConstraints { make in
			make.leading.equalTo(avatarImageView.snp.trailing).offset(textImagePadding)
			make.top.equalTo(avatarImageView.snp.top)
			make.trailing.equalTo(view.snp.trailing).inset(padding)
			make.height.equalTo(38)
		}
		
		nameLabel.snp.makeConstraints { make in
			make.leading.equalTo(avatarImageView.snp.trailing).offset(textImagePadding)
			make.top.equalTo(usernameLabel.snp.bottom).offset(lineGap)
			make.trailing.equalTo(view.snp.trailing).inset(padding)
			make.height.equalTo(20)
		}
		
		locationImageView.snp.makeConstraints { make in
			make.leading.equalTo(avatarImageView.snp.trailing).offset(textImagePadding)
			make.top.equalTo(nameLabel.snp.bottom).offset(lineGap)
			make.height.width.equalTo(20)
		}
		
		locationLabel.snp.makeConstraints { make in
			make.leading.equalTo(locationImageView.snp.trailing).offset(textImagePadding)
			make.trailing.equalTo(view.snp.trailing).inset(padding)
			make.top.equalTo(nameLabel.snp.bottom).offset(lineGap)
			make.height.equalTo(20)
		}
		
		bioLabel.snp.makeConstraints { make in
			make.leading.trailing.equalTo(view).inset(padding)
			make.top.equalTo(avatarImageView.snp.bottom).offset(padding)
			bioLabelHeightConstraint = make.height.equalTo(50).constraint.layoutConstraints[0]
		}
	}
}
