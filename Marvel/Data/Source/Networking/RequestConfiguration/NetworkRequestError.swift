import Foundation

enum NetworkRequestError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError(EncodingError)

    init?(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            self = .transportError(error)
        } else if let response = response as? HTTPURLResponse,
                  !(200...299).contains(response.statusCode) {
            self = .serverError(statusCode: response.statusCode)
        } else if data == nil {
            self = .noData
        } else {
            return nil
        }
    }
}

enum EncodingError : String, Error {
    case parametersNil = "parameter_missing"
    case encodingFailed = "encoding_failed"
    case missingURL = "url_missing"
}
