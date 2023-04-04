//
//  FavoriteCell.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 03.04.2023.
//

import UIKit
import SnapKit

class FavoriteCell: UITableViewCell {

	static let reuseID = Constants.CellsNames.favoriteCell
	
	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
	
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	func set(favorite: Follower) {
		usernameLabel.text = favorite.login
		if let url = favorite.avatarURL {
			avatarImageView.getImage(from: url)
		}
	}
	
	
	private func configure() {
		addSubview(avatarImageView)
		addSubview(usernameLabel)
		
		avatarImageView.translatesAutoresizingMaskIntoConstraints = false
		usernameLabel.translatesAutoresizingMaskIntoConstraints = false
		
		accessoryType = .disclosureIndicator
		
		let padding: CGFloat = 12
		
		avatarImageView.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.leading.equalToSuperview().offset(padding)
			make.height.width.equalTo(60)
		}
		
		usernameLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.leading.equalTo(avatarImageView.snp.trailing).offset(padding)
			make.trailing.equalToSuperview().inset(padding)
			make.height.equalTo(40)
		}
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		avatarImageView.image = avatarImageView.placeholderImage

	}
}
