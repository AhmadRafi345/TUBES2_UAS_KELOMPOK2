// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let voteResponsModelGet = try? JSONDecoder().decode(VoteResponsModelGet.self, from: jsonData)

import Foundation

// MARK: - VoteResponsModelGetElement
struct VoteResponsModelGetElement: Codable {
    let id: Int
    let imageID: String
    let subID: String?
    let createdAt: String
    let value: Int
    let countryCode: JSONNull?
    let image: Image

    enum CodingKeys: String, CodingKey {
        case id
        case imageID = "image_id"
        case subID = "sub_id"
        case createdAt = "created_at"
        case value
        case countryCode = "country_code"
        case image
    }
}

// MARK: - Image
struct Image: Codable {
    let id: String
    let url: String
}

typealias VoteResponsModelGet = [VoteResponsModelGetElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}
