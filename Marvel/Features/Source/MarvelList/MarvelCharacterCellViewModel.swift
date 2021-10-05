import Foundation

struct MarvelCharacterCellViewModel: Equatable {
    let name: String
    let imageURL: URL?

    init(model: CharactersModel) {
        self.name = model.name
        self.imageURL =  model.thumbnail
    }
}
