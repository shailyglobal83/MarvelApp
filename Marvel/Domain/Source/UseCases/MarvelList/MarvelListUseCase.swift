import Foundation

protocol MarvelListUseCaseContract {
    typealias Completion = (_ result: Result<MarvelListModel, NetworkRequestError>) -> Void

    func start(model: MarvelListConfigModel, completion: @escaping Completion)
}

final class MarvelListUseCase: MarvelListUseCaseContract {
    private let provider: MarvelServiceProviderContract

    init(provider: MarvelServiceProviderContract = MarvelServiceProvider()) {
        self.provider = provider
    }

    func start(model: MarvelListConfigModel, completion: @escaping Completion) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.provider.getMarvelList(model: model) { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
}
