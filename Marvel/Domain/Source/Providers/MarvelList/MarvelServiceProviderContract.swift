protocol MarvelServiceProviderContract {
    typealias MarvelListCompletion = (_ result: Result<MarvelListModel, NetworkRequestError>) -> Void
    typealias CharacterDetailsCompletion = (_ result: Result<CharacterDetailsModel, NetworkRequestError>) -> Void

    func getMarvelList(model: MarvelListConfigModel, completion: @escaping MarvelListCompletion)
    func getCharacterDetails(id: Int, completion: @escaping CharacterDetailsCompletion)
}
