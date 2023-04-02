//
//  GFSecondaryTitleLabel.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 27.03.2023.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init(fontSize: CGFloat) {
		super.init(frame: .zero)
		font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
		configure()
	}
	
	private func configure() {
		textColor = .secondaryLabel
		adjustsFontSizeToFitWidth = true
		font = UIFont.preferredFont(forTextStyle: .body)
		minimumScaleFactor = 0.9
		lineBreakMode = .byTruncatingTail
		translatesAutoresizingMaskIntoConstraints = false
	}
}
