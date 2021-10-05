import XCTest
@testable import Marvel

class MarvelProviderTest: XCTestCase {
    func testGetMarvelListAPISuccess() {
        let success = expectation(description: "success")
        let mockData = getMock(name: "MarvelListMock")
        let netMock = NetworkServiceMock(responseHandler: .success(mockData))
        let provider = MarvelServiceProvider(serviceRequest: netMock)
        provider.getMarvelList(model: MarvelListConfigModel.dummyInstance()) { result in
            if case .success = result {
                success.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetMarvelListAPIFailure() {
        let error = expectation(description: "Error")
        let mock = NetworkServiceMock(responseHandler: .failure(.serverError(statusCode: 404)))
        let provider = MarvelServiceProvider(serviceRequest: mock)
        provider.getMarvelList(model: MarvelListConfigModel.dummyInstance()) { result in
            if case .failure = result {
                error.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetCharacterDetailsAPISuccess() {
        let success = expectation(description: "success")
        let mockData = getMock(name: "MarvelListMock")
        let mock = NetworkServiceMock(responseHandler: .success(mockData))
        let provider = MarvelServiceProvider(serviceRequest: mock)
        provider.getCharacterDetails(id: 123) { result in
            if case .success = result {
                success.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetCharacterDetailsAPIFailure() {
        let error = expectation(description: "Error")
        let mock = NetworkServiceMock(responseHandler: .failure(.serverError(statusCode: 404)))
        let provider = MarvelServiceProvider(serviceRequest: mock)
        provider.getCharacterDetails(id: 123) { result in
            if case .failure = result {
                error.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func getMock(name: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let filePath = bundle.path(forResource: name, ofType: "json"),
              let data = try? String(contentsOfFile: filePath).data(using: .utf8) else {
            return Data()
        }
        return data
    }
}
