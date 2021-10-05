import Foundation

struct CharactersEntity: Codable {
    let id: Int?
    let name: String?
    let thumbnail: CharactersThumbnailEntity?

    func toDomain() throws -> CharactersModel {
        guard let id = id else {
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: [], debugDescription: "Unable to map id"))
        }
        guard let name = name else {
            throw DecodingError.valueNotFound(String.self, DecodingError.Context(codingPath: [], debugDescription: "Unable to map name"))
        }
        return CharactersModel(id: id, name: name, thumbnail: thumbnail?.toDomain())
    }
}
