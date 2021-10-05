struct CharacterListEntity: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let results: [CharactersEntity]?

    func toDomain() throws -> MarvelListModel {
        guard let offset = offset else {
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: [], debugDescription: "Unable to map offset"))
        }
        guard let limit = limit else {
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: [], debugDescription: "Unable to map limit"))
        }
        guard let total = total else {
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: [], debugDescription: "Unable to map total"))
        }
        guard let models = results?.compactMap({ charactersEntity in
            return try? charactersEntity.toDomain()
        })  else {
            throw DecodingError.valueNotFound([CharactersEntity].self, DecodingError.Context(codingPath: [], debugDescription: "Unable to map results"))
        }
        return MarvelListModel(offset: offset, limit: limit, total: total, items: models)
    }
}
