import Foundation
@testable import Marvel

typealias ResponseHandler = Result<Data, NetworkRequestError>
final class NetworkServiceMock: NetworkRequestContract {

    var responseHandler: ResponseHandler

    init(responseHandler: ResponseHandler) {
        self.responseHandler = responseHandler
    }

    func request(endPoint: EndPointConfiguration, completion: @escaping CompletionHandler) {
        completion(responseHandler)
    }

    func cancel() { }
}
