//
//  FollowerViewCell.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 17.03.2023.
//

import UIKit
import SnapKit

class FollowerViewCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        if let url = follower.avatarURL {
            print("Requested")
            avatarImageView.getImage(from: url)
        }
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        avatarImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView).inset(8)
            make.height.equalTo(avatarImageView.snp.width)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(12)
            make.leading.trailing.equalTo(contentView).inset(8)
            make.height.equalTo(20)
        }
    }
}
