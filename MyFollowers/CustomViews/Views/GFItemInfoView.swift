//
//  GFItemInfoView.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 01.04.2023.
//

import UIKit
import SnapKit

enum ItemInfoType {
	case repos, gists, followers, following
}


final class GFItemInfoView: UIView {

    let symbolImageView = UIImageView()
	let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
	let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureLayout()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	private func configureLayout() {
		addSubview(symbolImageView)
		addSubview(titleLabel)
		addSubview(countLabel)
		
		symbolImageView.translatesAutoresizingMaskIntoConstraints = false
		symbolImageView.contentMode = .scaleAspectFill
		symbolImageView.tintColor = .label
		
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		countLabel.translatesAutoresizingMaskIntoConstraints = false
		
		symbolImageView.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.equalToSuperview()
			make.width.height.equalTo(20)
		}
		
		titleLabel.snp.makeConstraints { make in
			make.leading.equalTo(symbolImageView.snp.trailing).offset(12)
			make.trailing.equalToSuperview()
			make.centerY.equalTo(symbolImageView)
			make.height.equalTo(18)
		}
		
		countLabel.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.top.equalTo(symbolImageView.snp.bottom).offset(5)
			make.height.equalTo(18)
		}
	}
	
	
	func set(itemInfoType: ItemInfoType, with count: Int) {
		switch itemInfoType {
			case .repos:
				symbolImageView.image = UIImage(systemName: Constants.Icons.repos)
				titleLabel.text = "Public repos"
			case .gists:
				symbolImageView.image = UIImage(systemName: Constants.Icons.gists)
				titleLabel.text = "Public gists"
			case .followers:
				symbolImageView.image = UIImage(systemName: Constants.Icons.followers)
				titleLabel.text = "Followers"
			case .following:
				symbolImageView.image = UIImage(systemName: Constants.Icons.following)
				titleLabel.text = "Following"
		}
		
		countLabel.text = String(count)
	}
}
