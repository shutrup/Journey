import Foundation

struct Tour: Codable, Hashable {
    let id, name, description: String
    let groupSize: Int
    let images: [String]
    let pricePerPerson, rating: Int
    let categoryIDS, includedOptionIDS: [String]
    let locates: [Locate]
    let gidIDS: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, description, groupSize, images, pricePerPerson, rating
        case categoryIDS = "categoryIds"
        case includedOptionIDS = "includedOptionIds"
        case locates
        case gidIDS = "gidIds"
    }
}

struct Locate: Codable, Hashable {
    let title: String
    let latitude, longitude: Double
    let id: String

    enum CodingKeys: String, CodingKey {
        case title, latitude, longitude
        case id = "_id"
    }
}
