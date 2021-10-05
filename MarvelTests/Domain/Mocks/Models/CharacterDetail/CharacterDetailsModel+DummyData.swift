import Foundation

@testable import Marvel

extension CharacterDetailsModel {
    static func dummyInstance() -> CharacterDetailsModel {
        CharacterDetailsModel(id: 1,
                              description: "Testing",
                              name: "Test Name",
                              thumbnail: URL(string: "www.testurl.com"))
    }
}
