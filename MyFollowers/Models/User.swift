//
//  User.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 16.03.2023.
//

import Foundation

struct User: Decodable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
	
	enum CodingKeys: String, CodingKey {
		case login
		case name
		case location
		case bio
		case following
		case followers
		case avatarUrl = "avatar_url"
		case publicRepos = "public_repos"
		case publicGists = "public_gists"
		case htmlUrl = "html_url"
		case createdAt = "created_at"
		
	}

}

