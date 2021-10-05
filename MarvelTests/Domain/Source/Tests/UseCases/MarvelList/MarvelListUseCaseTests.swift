import XCTest

@testable import Marvel

class MarvelListUseCaseTests: XCTestCase {
    private var marvelListUseCase: MarvelListUseCase!
    var marvelServiceProviderMock = MarvelServiceProviderMock()

    override func setUp() {
        super.setUp()
        marvelListUseCase = MarvelListUseCase(provider: marvelServiceProviderMock)
    }

    func testGetMarvelListUseCaseSuccess() {
        let expectation = XCTestExpectation(description: "Success")
        marvelServiceProviderMock.getMarvelList = .success(MarvelListModel.dummyInstance())
        marvelListUseCase.start(model: MarvelListConfigModel.dummyInstance()) { result in
            if case .success = result {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }


    func testGetMarvelListUseCaseFailure() {
        let expectation = XCTestExpectation(description: "Server Error")
        marvelServiceProviderMock.getMarvelList = .failure(NetworkRequestError.serverError(statusCode: 299))
        marvelListUseCase.start(model: MarvelListConfigModel.dummyInstance()) { result in
            if case .failure = result {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }
}
