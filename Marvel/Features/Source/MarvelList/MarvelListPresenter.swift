import Foundation

enum MarvelListViewState: Equatable {
    case loadView
    case loading
    case render
    case error
}

protocol MarvelListPresenterContract: PresenterContract {
    var view: MarvelListViewContract? { get set }
    var navigationBuilder: MarvelLisNavigationBuilderContract? { get set }

    func numberOfRowsIn(section: Int) -> Int
    func viewModelAt(indexPath: IndexPath) -> MarvelCharacterCellViewModel?
    func didSelectRowAt(indexPath: IndexPath)
    func didCollectionViewScrollToEnd() 
}

class MarvelListPresenter: MarvelListPresenterContract {
    private let marvelListUseCase : MarvelListUseCaseContract?
    private var marvelListModel: MarvelListModel? {
        didSet {
            guard let model = marvelListModel else {
                return
            }
            characterModels = characterModels + model.items
            isLoadMore = characterModels.count != marvelListModel?.total
        }
    }
    private var characterModels: [CharactersModel] = []
    private var offset = 0
    private var isLoadMore = true
    weak var view: MarvelListViewContract?
    var navigationBuilder: MarvelLisNavigationBuilderContract?

    init(marvelListUseCase: MarvelListUseCaseContract = MarvelListUseCase()) {
        self.marvelListUseCase = marvelListUseCase
    }

    private var viewState: MarvelListViewState = .loadView {
        didSet {
            view?.changeState(state: viewState)
        }
    }

    func viewLoaded() {
        requestForGetMarvelCharacterList()
    }

    func numberOfRowsIn(section: Int) -> Int {
        return characterModels.count
    }

    func viewModelAt(indexPath: IndexPath) -> MarvelCharacterCellViewModel? {
        return MarvelCharacterCellViewModel(model: characterModels[indexPath.row])
    }

    func didSelectRowAt(indexPath: IndexPath) {
        navigationBuilder?.navigateToMarvelDetails(id: characterModels[indexPath.row].id)
    }

    func didCollectionViewScrollToEnd() {
        requestForGetMarvelCharacterList()
    }

    private func requestForGetMarvelCharacterList() {
        guard viewState != .loading, isLoadMore else {
            return
        }
        viewState = .loading
        let model = MarvelListConfigModel(offset: offset, limit: 25)
        marvelListUseCase?.start(model: model) { [weak self] result in
            switch result {
            case let .success(model):
                self?.marvelListModel = model
                self?.offset = model.offset + 1
                self?.viewState = .render
            case .failure:
                self?.viewState = .error
            }
        }
    }
}
