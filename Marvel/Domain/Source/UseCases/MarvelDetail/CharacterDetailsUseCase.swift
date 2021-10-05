import Foundation

protocol CharacterDetailsUseCaseContract {
    typealias Completion = (_ result: Result<CharacterDetailsModel, NetworkRequestError>) -> Void

    func start(characterID: Int, completion: @escaping Completion)
}

final class CharacterDetailsUseCase: CharacterDetailsUseCaseContract {
    private let provider: MarvelServiceProviderContract

    init(provider: MarvelServiceProviderContract = MarvelServiceProvider()) {
        self.provider = provider
    }

    func start(characterID: Int, completion: @escaping Completion) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.provider.getCharacterDetails(id: characterID) { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
}
