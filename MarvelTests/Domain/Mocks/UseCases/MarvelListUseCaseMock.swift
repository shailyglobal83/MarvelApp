@testable import Marvel

final class MarvelListUseCaseMock: MarvelListUseCaseContract {
    var result: Result<MarvelListModel, NetworkRequestError>?

    func start(model: MarvelListConfigModel, completion: @escaping Completion) {
        guard let result = result else {
            fatalError("Mock response required")
        }
        completion(result)
    }
}
