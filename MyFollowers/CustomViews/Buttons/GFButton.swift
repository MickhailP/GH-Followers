//
//  GFButton.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 14.03.2023.
//

import UIKit

final class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

	
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }

	
    private func configure() {
        layer.cornerRadius                          = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font                            = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints   = false
    }
	
	
	func set(backgroundColor: UIColor, title: String)  {
		self.backgroundColor = backgroundColor
		setTitle(title, for: .normal)
	}
}

