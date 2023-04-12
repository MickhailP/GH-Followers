//
//  UIViewEXT.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 10.04.2023.
//

import Foundation
import UIKit

extension UIView {
	func addSubViews(_ views: UIView...) {
		views.forEach { addSubview($0) }
	}
}
