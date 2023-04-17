//
//  GFBodyLabel.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 15.03.2023.
//

import UIKit

final class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
		configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


	convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }

	
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        font = UIFont.preferredFont(forTextStyle: .body)
		adjustsFontForContentSizeCategory = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping //WORD WRAPPING
		numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
}
