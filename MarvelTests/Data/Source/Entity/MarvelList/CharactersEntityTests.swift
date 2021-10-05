import XCTest

@testable import Marvel

class CharactersEntityTests: XCTestCase {

    func testMarvelCharacterEntityToDomain() {
        let entity = CharactersEntity(id: 123,
                                      name: "Test",
                                      thumbnail: CharactersThumbnailEntity(path: "www.test.com",
                                                                           imageExtension: "jpg"))
        guard let model = try? entity.toDomain() else {
            XCTFail("Domain Model Conversion Failed")
            return
        }
        XCTAssertEqual(model.id, 123)
        XCTAssertEqual(model.name, "Test")
    }


    func testMarvelCharacterEntityInvalidName() {
        let entity = CharactersEntity(id: 123,
                                      name: nil,
                                      thumbnail: CharactersThumbnailEntity(path: "www.test.com",
                                                                           imageExtension: "jpg"))
        XCTAssertThrowsError(try entity.toDomain()) { error in
            guard case let .valueNotFound(_, context) = error as? DecodingError else {
                return XCTFail("Unable to get error for testMarvelCharacterEntityInvalidName")
            }
            XCTAssertEqual(context.debugDescription, "Unable to map name")
        }
    }

    func testMarvelCharacterEntityInvalidID() {
        let entity = CharactersEntity(id: nil,
                                      name: "Test",
                                      thumbnail: CharactersThumbnailEntity(path: "www.test.com",
                                                                           imageExtension: "jpg"))
        XCTAssertThrowsError(try entity.toDomain()) { error in
            guard case let .valueNotFound(_, context) = error as? DecodingError else {
                return XCTFail("Unable to get error for testMarvelCharacterEntityInvalidID")
            }
            XCTAssertEqual(context.debugDescription, "Unable to map id")
        }
    }
}
