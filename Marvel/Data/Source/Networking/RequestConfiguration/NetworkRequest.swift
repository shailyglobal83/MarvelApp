import Foundation

typealias CompletionHandler = (Result<Data, NetworkRequestError>) -> Void

protocol NetworkRequestContract: AnyObject {
    func request(endPoint: EndPointConfiguration, completion: @escaping CompletionHandler)
    func cancel()
}

final class NetworkRequest: NetworkRequestContract {
    private var task: URLSessionTask?
    
    func request(endPoint: EndPointConfiguration, completion: @escaping CompletionHandler) {
        let session = URLSession.shared
        do {
            let request = try self.getConfiguredURLRequest(endPoint: endPoint)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                if let networkError = NetworkRequestError(data: data, response: response, error: error) {
                    completion(.failure(networkError))
                } else {
                    completion(.success(data ?? Data()))
                }
            })
        }catch {
            completion(.failure(.encodingError(.encodingFailed)))
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    private func getConfiguredURLRequest(endPoint: EndPointConfiguration) throws -> URLRequest {
        
        var request = URLRequest(url: endPoint.baseURL.appendingPathComponent(endPoint.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = endPoint.httpMethod.rawValue
        do {
            switch endPoint.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    private func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters,
                                    urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}

