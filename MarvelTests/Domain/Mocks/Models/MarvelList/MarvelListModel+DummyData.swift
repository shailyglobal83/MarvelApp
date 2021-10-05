@testable import Marvel

extension MarvelListModel {
    static func dummyInstance() -> MarvelListModel {
        MarvelListModel(offset: 1,
                        limit: 20,
                        total: 100,
                        items: [CharactersModel.dummyInstance()])
    }
}






