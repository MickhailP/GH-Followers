//
//  UIViewEXT.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 10.04.2023.
//

import Foundation
import UIKit
import SnapKit

extension UIView {

	func pinToEdges(of superview: UIView) {
		translatesAutoresizingMaskIntoConstraints = false

		self.snp.makeConstraints { make in
			make.top.equalTo(superview.snp.top)
			make.leading.trailing.equalToSuperview()
			make.bottom.equalTo(superview.snp.bottom)
		}
	}

	
	func addSubViews(_ views: UIView...) {
		views.forEach { addSubview($0) }
	}
}
