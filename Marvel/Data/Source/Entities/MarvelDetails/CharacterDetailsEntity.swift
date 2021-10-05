import Foundation

struct CharacterDetailsEntity: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: CharactersThumbnailEntity?

    func toDomain() throws -> CharacterDetailsModel {
        guard let id = id else {
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: [], debugDescription: "Unable to map id"))
        }
        guard let name = name else {
            throw DecodingError.valueNotFound(String.self, DecodingError.Context(codingPath: [], debugDescription: "Unable to map name"))
        }

        guard let description = description else {
            throw DecodingError.valueNotFound(String.self, DecodingError.Context(codingPath: [], debugDescription: "Unable to map character Description"))
        }
        return CharacterDetailsModel(id: id,
                                     description: description,
                                     name: name,
                                     thumbnail: thumbnail?.toDomain())
    }
}
