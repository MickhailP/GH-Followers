//
//  ErrorMessages.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 17.03.2023.
//

import Foundation

enum ErrorMessages: String, Error {
    case invalidUsername = "Wrong name"
    case invalidResponse = "Try again"
    case invalidData = "Data is missing"
    case decodingError = "Decoding"
}
