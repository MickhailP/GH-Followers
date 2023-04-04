//
//  Constants.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 15.03.2023.
//

import Foundation

enum Constants {
    
	enum Icons {
		static let repos = "folder"
		static let gists = "text.alignleft"
		static let followers = "heart"
		static let following = "person.2"
	}
	
	enum Images{
        static let logo = "gh-logo"
		static let emptyStateLogo = "empty-state-logo"
		static let location = "mappin.and.ellipse"
    }
    
	enum ViewSize {
        static let buttonHeight = 44
    }
    
	enum CellsNames {
        static let followerCell = "FollowerCell"
		static let favoriteCell = "FavoriteCell"
    }
    
	enum FontSizes {
		static let header1: CGFloat = 34
		static let header2: CGFloat = 18
	}
}
