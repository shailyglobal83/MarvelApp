import Foundation
import JSONDecoder_Keypath

final class MarvelServiceProvider: MarvelServiceProviderContract {
    private var serviceRequest : NetworkRequestContract!

    init(serviceRequest: NetworkRequestContract = NetworkRequest()) {
        self.serviceRequest = serviceRequest
    }

    func getMarvelList(model: MarvelListConfigModel, completion: @escaping MarvelListCompletion) {
        let requestEntity = MarvelListRequestEntity(model: model)
        serviceRequest.request(endPoint: MarvelService.marvelList(entity: requestEntity)) { response in
            switch response {
            case let .success(data):
                do {
                    let responseEntity = try JSONDecoder().decode(CharacterListEntity.self, from: data, keyPath: "data")
                    let model = try responseEntity.toDomain()
                    completion(.success(model))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func getCharacterDetails(id: Int, completion: @escaping CharacterDetailsCompletion) {
        serviceRequest.request(endPoint: MarvelService.characterDetails(id: id)) { response in
            switch response {
            case let .success(data):
                do {
                    let responseEntity = try JSONDecoder().decode([CharacterDetailsEntity].self, from: data, keyPath: "data.results")
                    if let model = try  responseEntity.first?.toDomain() {
                        completion(.success(model))
                    } else {
                        completion(.failure(.noData))
                    }
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
