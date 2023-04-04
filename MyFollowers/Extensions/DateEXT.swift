//
//  DateEXT.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 02.04.2023.
//

import Foundation


extension Date {
	func convertToMontYearFormat() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM yyyy"
		return dateFormatter.string(from: self)
	}
}
