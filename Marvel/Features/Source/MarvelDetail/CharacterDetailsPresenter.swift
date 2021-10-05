import Foundation

protocol CharacterDetailsPresenterContract: PresenterContract {
    var view: CharacterDetailsViewContract? { get set }
    var id: Int? { get set}
}

enum CharacterDetailsViewState: Equatable {
    case loadView
    case loading
    case render(CharacterDetailsViewModel)
    case error
}

class CharacterDetailsPresenter: CharacterDetailsPresenterContract {
    weak var view: CharacterDetailsViewContract?
    var id: Int?
    private var characterDetailsModel: CharacterDetailsModel?
    private let characterDetailsUseCase : CharacterDetailsUseCaseContract?

    init(characterDetailsUseCase: CharacterDetailsUseCaseContract = CharacterDetailsUseCase()) {
        self.characterDetailsUseCase = characterDetailsUseCase
    }

    private var viewState: CharacterDetailsViewState = .loadView {
        didSet {
            view?.changeState(state: viewState)
        }
    }

    func viewLoaded() {
        requestForGetMarvelCharacterDetails(id: id)
    }
}

private extension CharacterDetailsPresenter {

    func buildViewModel() -> CharacterDetailsViewModel {
        return CharacterDetailsViewModel(name: characterDetailsModel?.name ?? "",
                                         descriptionText: characterDetailsModel?.description ?? "",
                                         thumbnailURL: characterDetailsModel?.thumbnail)
    }

    func requestForGetMarvelCharacterDetails(id: Int?) {
        guard let id = id else {
            return
        }
        viewState = .loading
        characterDetailsUseCase?.start(characterID: id) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(model):
                self.characterDetailsModel = model
                self.viewState = .render(self.buildViewModel())
            case .failure:
                self.viewState = .error
            }
        }
    }
}
