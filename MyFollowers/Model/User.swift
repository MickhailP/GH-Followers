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
    let name: String?
    let location: String?
    let bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
