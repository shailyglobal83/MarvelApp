import XCTest

@testable import Marvel

class CharacterListEntityTests: XCTestCase {
    func testMarvelCharacterEntityToDomain() {
        let entity = CharacterListEntity(offset: 1,
                                         limit: 20,
                                         total: 123,
                                         results: [CharactersEntity]())
        guard let model = try? entity.toDomain() else {
            XCTFail("Domain Model Conversion Failed")
            return
        }
        XCTAssertEqual(model.offset, 1)
        XCTAssertEqual(model.limit, 20)
    }

    func testMarvelCharacterEntityInvalidOffset() {
        let entity = CharacterListEntity(offset: nil,
                                         limit: 20,
                                         total: 123,
                                         results: [CharactersEntity]())
        XCTAssertThrowsError(try entity.toDomain()) { error in
            guard case let .valueNotFound(_, context) = error as? DecodingError else {
                return XCTFail("Unable to get error for testMarvelCharacterEntityInvalidOffset")
            }
            XCTAssertEqual(context.debugDescription, "Unable to map offset")
        }
    }

    func testMarvelCharacterEntityInvalidLimit() {
        let entity = CharacterListEntity(offset: 1,
                                         limit: nil,
                                         total: 123,
                                         results: [CharactersEntity]())
        XCTAssertThrowsError(try entity.toDomain()) { error in
            guard case let .valueNotFound(_, context) = error as? DecodingError else {
                return XCTFail("Unable to get error for testMarvelCharacterEntityInvalidLimit")
            }
            XCTAssertEqual(context.debugDescription, "Unable to map limit")
        }
    }

    func testMarvelCharacterEntityInvalidTotal() {
        let entity = CharacterListEntity(offset: 1,
                                         limit: 20,
                                         total: nil,
                                         results: [CharactersEntity]())
        XCTAssertThrowsError(try entity.toDomain()) { error in
            guard case let .valueNotFound(_, context) = error as? DecodingError else {
                return XCTFail("Unable to get error for testMarvelCharacterEntityInvalidTotal")
            }
            XCTAssertEqual(context.debugDescription, "Unable to map total")
        }
    }

    func testMarvelCharacterEntityInvalidResult() {
        let entity = CharacterListEntity(offset: 1,
                                         limit: 20,
                                         total: 123,
                                         results: nil)
        XCTAssertThrowsError(try entity.toDomain()) { error in
            guard case let .valueNotFound(_, context) = error as? DecodingError else {
                return XCTFail("Unable to get error for testMarvelCharacterEntityInvalidResult")
            }
            XCTAssertEqual(context.debugDescription, "Unable to map results")
        }
    }
}
