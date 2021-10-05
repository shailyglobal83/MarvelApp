import Foundation

struct MarvelListModel {
    let offset: Int
    let limit: Int
    let total: Int
    let items: [CharactersModel]
}
