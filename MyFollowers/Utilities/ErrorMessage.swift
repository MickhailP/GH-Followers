//
//  ErrorMessage.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 17.03.2023.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidUsername = "Wrong name"
    case invalidResponse = "Try again"
    case invalidData = "Data is missing"
    case decodingError = "Decoding"
	case unableFavourites = "Failed to load data from storage."
	case alreadySaved = "This follower has been saved already."
}
