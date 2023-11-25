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

struct Tour: Codable, Hashable {
    let id: String
    let name: String
    let description: String
    let groupSize: Int
    let images: [String]
    let pricePerPerson: Int
    let rating: Double
    let categoryIds: [String]
    let includedOptionIds: [String]
    let locates: [Location]
    let gidIds: [String]
    let place: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case description
        case groupSize
        case images
        case pricePerPerson
        case rating
        case categoryIds
        case includedOptionIds
        case locates
        case gidIds
        case place
    }
}

extension Tour {
    static var FETCH_MOCK: Tour {
        Tour(
            id: "6505ae3cde799f5d87c4c239",
            name: "Сулакский каньон",
            description: "Самый глубокий каньон Европы — гордость Дагестана и однозначное must-see место, без которого представление о республике было бы неполным...",
            groupSize: 10,
            images: [
                "https://cdn.tripster.ru/thumbs2/08450454-a1f7-11ec-bb18-ca2ddeace350.800x600.jpeg",
                "https://cdn.tripster.ru/thumbs2/0694b1c2-a1f7-11ec-a5dc-8e6bfaace1f9.800x600.jpeg",
                "https://cdn.tripster.ru/thumbs2/26460f34-a1d9-11ec-a70c-661acc80cf0a.800x600.jpeg"
            ],
            pricePerPerson: 3800,
            rating: 5.0,
            categoryIds: ["650466244b2266eadcfb27e2", "650466434b2266eadcfb27ec"],
            includedOptionIds: ["6505a4b6c4161ee9068aeaff", "6505a4bfc4161ee9068aeb01", "6505a4e7c4161ee9068aeb05"],
            locates: [
                Location(id: "6505ae3cde799f5d87c4c23a", title: "Посёлок Дубки", latitude: 43.020873, longitude: 46.837476),
                Location(id: "6505ae3cde799f5d87c4c23b", title: "с. Зубутли", latitude: 43.007834, longitude: 46.821935),
            ],
            gidIds: ["650471094556f0adb32a4c0c"],
            place: "г. Дербент"
        )
    }
}
