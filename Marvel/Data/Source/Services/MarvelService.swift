import Foundation

enum MarvelService {
    case marvelList(entity: MarvelListRequestEntity)
    case characterDetails(id: Int)
}

extension MarvelService: EndPointConfiguration {
    var path: String {
        switch self {
        case .marvelList:
            return "/v1/public/characters"
        case .characterDetails(let id):
            return "/v1/public/characters/\(id)"
        }
    }
    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        switch self {
        case .marvelList(let entity):
            var urlParameters: Parameters = ["offset": entity.offset, "limit": entity.limit, "ts": 1]
            configureCommonParameters(parameters: &urlParameters)
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: urlParameters)
        case .characterDetails:
            var params: Parameters = ["ts": 1]
            configureCommonParameters(parameters: &params)
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: params)
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}
