import Foundation

@testable import Marvel

extension CharactersModel {
    static func dummyInstance() -> CharactersModel {
        CharactersModel(id: 123,
                        name: "Test",
                        thumbnail: URL(string: "www.testurl.com"))
    }
}
