//
//  GFAvatarImageView.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 17.03.2023.
//

import UIKit

final class GFAvatarImageView: UIImageView {
	
	let placeholderImage = Constants.Images.placeholderImage
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	
	private func configure() {
		layer.cornerRadius = 10
		clipsToBounds = true
		
		if let placeholderImage {
			image = placeholderImage
		}
		
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	
	func getImage(from url: String) {
		Task {
			if let image = await NetworkManager.shared.downloadImage(from: url) {
				await MainActor.run {
					self.image = image
				}
			}
		}
	}
}

