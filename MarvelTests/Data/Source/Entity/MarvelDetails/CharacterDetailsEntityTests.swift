import XCTest

@testable import Marvel

class CharacterDetailsEntityTests: XCTestCase {
    func testCharacterDetailsEntityToDomain() {
        let entity = CharacterDetailsEntity(id: 123,
                                            name: "Testing",
                                            description: "Description",
                                            thumbnail: CharactersThumbnailEntity(path: "testing",
                                                                                 imageExtension: "jpg"))
        guard let model = try? entity.toDomain() else {
            XCTFail("Domain Model Conversion Failed")
            return
        }
        XCTAssertEqual(model.id, 123)
        XCTAssertEqual(model.name, "Testing")
        XCTAssertEqual(model.description, "Description")
    }

    func testCharacterDetailsEntityInvalidID() {
        let entity = CharacterDetailsEntity(id: nil,
                                            name: "Testing",
                                            description: "Description",
                                            thumbnail: CharactersThumbnailEntity(path: "testing",
                                                                                 imageExtension: "jpg"))
        XCTAssertThrowsError(try entity.toDomain())
    }

    func testCharacterDetailsEntityInvalidName() {
        let entity = CharacterDetailsEntity(id: 123,
                                            name: nil,
                                            description: "Description",
                                            thumbnail: CharactersThumbnailEntity(path: "testing",
                                                                                 imageExtension: "jpg"))
        XCTAssertThrowsError(try entity.toDomain()) { error in
            guard case let .valueNotFound(_, context) = error as? DecodingError else {
                return XCTFail("Unable to get error for testCharacterDetailsEntityInvalidName")
            }
            XCTAssertEqual(context.debugDescription, "Unable to map name")
        }

        XCTAssertThrowsError(try entity.toDomain())
    }

    func testCharacterDetailsEntityInvalidDescription() {
        let entity = CharacterDetailsEntity(id: 123,
                                            name: "Testing",
                                            description: nil,
                                            thumbnail: CharactersThumbnailEntity(path: "testing",
                                                                                 imageExtension: "jpg"))
        XCTAssertThrowsError(try entity.toDomain()) { error in
            guard case let .valueNotFound(_, context) = error as? DecodingError else {
                return XCTFail("Unable to get error for testCharacterDetailsEntityInvalidDescription")
            }
            XCTAssertEqual(context.debugDescription, "Unable to map character Description")
        }
    }
}
