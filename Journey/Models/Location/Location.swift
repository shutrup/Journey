import Foundation

struct Location: Codable, Hashable {
    let id: String
    let title: String
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case latitude
        case longitude
    }
}
