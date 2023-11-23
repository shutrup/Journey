//
//  User.swift
//  Journey
//
//  Created by Шарап Бамматов on 22.11.2023.
//

import Foundation

struct User: Codable, Hashable {
    let _id: String
    let name: String
    let email: String
    let createAt: String
}
