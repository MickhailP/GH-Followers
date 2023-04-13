//
//  Constants.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 15.03.2023.
//

import Foundation
import UIKit

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
		static let placeholderImage  = UIImage(named: "avatar-placeholder")
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
	
	
	enum ScreenSize {
		static let width        = UIScreen.main.bounds.size.width
		static let height       = UIScreen.main.bounds.size.height
		static let maxLength    = max(ScreenSize.width, ScreenSize.height)
		static let minLength    = min(ScreenSize.width, ScreenSize.height)
	}
	
	
	enum DeviceTypes {
		static let idiom                    = UIDevice.current.userInterfaceIdiom
		static let nativeScale              = UIScreen.main.nativeScale
		static let scale                    = UIScreen.main.scale
		
		static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
		static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
		static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
		static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
		static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
		static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
		static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
		static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0
		
		static func isiPhoneXAspectRatio() -> Bool {
			return isiPhoneX || isiPhoneXsMaxAndXr
		}
	}
}
