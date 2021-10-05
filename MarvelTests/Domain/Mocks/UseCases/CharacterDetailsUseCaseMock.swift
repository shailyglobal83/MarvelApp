@testable import Marvel

final class CharacterDetailsUseCaseMock: CharacterDetailsUseCaseContract {
    var result: Result<CharacterDetailsModel, NetworkRequestError>?

    func start(characterID: Int, completion: @escaping Completion) {
        guard let result = result else {
            fatalError("Mock response required")
        }
        completion(result)
    }
}
