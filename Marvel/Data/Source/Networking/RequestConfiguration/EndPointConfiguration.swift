import Foundation

protocol EndPointConfiguration {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

extension EndPointConfiguration {
    var environmentBaseURL : String {
        return "https://gateway.marvel.com"
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("Unable to configure base URL")}
        return url
    }

    func configureCommonParameters(parameters: inout Parameters) {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String,
              let hash = Bundle.main.infoDictionary?["HASH_KEY"] as? String  else {
            return
        }
        parameters["apikey"] = apiKey
        parameters["hash"] = hash
    }
}

