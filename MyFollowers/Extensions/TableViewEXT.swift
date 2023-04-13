//
//  TableViewEXT.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 12.04.2023.
//

import Foundation
import UIKit

extension UITableView {

	func reloadDataOnMainThread() {
		DispatchQueue.main.async {
			self.reloadData()
		}
	}

	
	func removeExcessCells() {
		tableFooterView = UIView(frame: .zero)
	}
}
