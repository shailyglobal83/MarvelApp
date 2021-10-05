import Foundation

struct CharactersThumbnailEntity: Codable {
    let path: String?
    let imageExtension: String?

    private enum CodingKeys : String, CodingKey {
        case path
        case imageExtension = "extension"
    }

    func toDomain() -> URL? {
        let imageURL = "\(path ?? "").\(imageExtension ?? "")"
        return URL(string: imageURL)
    }
}
