//
//  GFEmptyView.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 22.03.2023.
//

import UIKit
import SnapKit

class GFEmptyView: UIView {
	
	let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
	let logoImage = UIImageView()


	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	convenience init(message: String) {
		self.init(frame: .zero)
		messageLabel.text = message
	}
	
	
	private func configure() {
		addSubViews(messageLabel, logoImage)

		messageLabel.numberOfLines = 3
		messageLabel.textColor = .secondaryLabel
		
		logoImage.image = UIImage(named: Constants.Images.emptyStateLogo)
		logoImage.translatesAutoresizingMaskIntoConstraints = false
		
		let messageLabelCenterYConstant: CGFloat = Constants.DeviceTypes.isiPhoneSE || Constants.DeviceTypes.isiPhone8Zoomed ? -50 : -150
		let logoBottomConstant: CGFloat = Constants.DeviceTypes.isiPhoneSE || Constants.DeviceTypes.isiPhone8Zoomed ? 100 : 60
		
		messageLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview().offset(messageLabelCenterYConstant)
			make.leading.trailing.equalToSuperview().inset(40)
			make.height.equalTo(200)
			
		}
		
		logoImage.snp.makeConstraints { make in
			make.trailing.equalToSuperview().offset(170)
			make.bottom.equalToSuperview().offset(logoBottomConstant)
		}
	}
}
