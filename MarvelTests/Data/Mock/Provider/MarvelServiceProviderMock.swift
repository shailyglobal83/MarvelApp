@testable import Marvel

final class MarvelServiceProviderMock: MarvelServiceProviderContract {
    var getMarvelList: Result<MarvelListModel, NetworkRequestError>?
    var getCharacterDetails: Result<CharacterDetailsModel, NetworkRequestError>?

    func getMarvelList(model: MarvelListConfigModel, completion: @escaping MarvelListCompletion) {
        guard let result = getMarvelList else {
            fatalError("GetMarvelList Mock Not Provided")
        }
        completion(result)
    }

    func getCharacterDetails(id: Int, completion: @escaping CharacterDetailsCompletion) {
        guard let result = getCharacterDetails else {
            fatalError("GetMarvelList Mock Not Provided")
        }
        completion(result)
    }
}
