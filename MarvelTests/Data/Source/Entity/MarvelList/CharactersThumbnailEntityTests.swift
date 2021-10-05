import XCTest

@testable import Marvel

class CharactersThumbnailEntityTests: XCTestCase {

    func testCharactersThumbnailEntityToDomain() {
        let entity = CharactersThumbnailEntity(path: "testing", imageExtension: "jpg")
        let expectedURL = URL(string: "testing.jpg")
        XCTAssertEqual(entity.toDomain(), expectedURL)
    }
}
