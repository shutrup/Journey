//
//  Gid.swift
//  Journey
//
//  Created by Шарап Бамматов on 25.11.2023.
//

import Foundation

struct Gid: Codable, Hashable {
    let _id, name: String
    let avatar: String
    let rating: Double
    let socials: [Social]
}

// MARK: - Social
struct Social: Codable, Hashable {
    let name, url, _id: String
}
