@testable import Marvel

extension MarvelListConfigModel {
    static func dummyInstance() -> MarvelListConfigModel {
        MarvelListConfigModel(offset: 1, limit: 20)
    }
}
