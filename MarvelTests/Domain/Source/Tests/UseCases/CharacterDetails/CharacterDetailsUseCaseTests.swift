import XCTest
@testable import Marvel

class CharacterDetailsUseCaseTests: XCTestCase {
    private var characterDetailsUseCase: CharacterDetailsUseCase!
    var marvelServiceProviderMock = MarvelServiceProviderMock()

    override func setUp() {
        super.setUp()
        characterDetailsUseCase = CharacterDetailsUseCase(provider: marvelServiceProviderMock)
    }

    func testGetMarvelListUseCaseSuccess() {
        let expectation = XCTestExpectation(description: "Success")
        marvelServiceProviderMock.getCharacterDetails = .success(CharacterDetailsModel.dummyInstance())
        characterDetailsUseCase.start(characterID: 123) { result in
            if case .success = result {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }


    func testGetMarvelListUseCaseFailure() {
        let expectation = XCTestExpectation(description: "Server Error")
        marvelServiceProviderMock.getCharacterDetails = .failure(NetworkRequestError.serverError(statusCode: 299))
        characterDetailsUseCase.start(characterID: 123) { result in
            if case .failure = result {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }
}
