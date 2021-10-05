import XCTest

@testable import Marvel

class NetworkLayerTests: XCTestCase {

    func testURLEncoding() {
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/characters") else {
            XCTAssertTrue(false, "Unable to form the URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        let parameters: Parameters = ["apiKey": "123", "ts": "1", "hash": "1234"]

        do {
            let encoder = URLParameterEncoder()
            try encoder.encode(urlRequest: &urlRequest, with: parameters)
            guard let fullURL = urlRequest.url else {
                XCTAssertTrue(false, "urlRequest url is nil.")
                return
            }

            let expectedURL = "https://gateway.marvel.com/v1/public/characters?apiKey=123&ts=1&hash=1234"
            XCTAssertEqual(fullURL.absoluteString.sorted(), expectedURL.sorted())
        }catch {
            XCTFail("Unable to encode the URL")
        }
    }
}
