import Foundation

final class MarvelListBuilder {
    let view: MarvelListViewContract
    let presenter: MarvelListPresenterContract
    weak var coordinator: MainCoordinator?

    init(view: MarvelListViewContract = MarvelListViewController.instantiate(),
         presenter: MarvelListPresenterContract = MarvelListPresenter()) {
        self.view = view
        self.presenter = presenter
    }

    func build() -> MarvelListViewContract {
        view.presenter = presenter
        presenter.view = view
        presenter.navigationBuilder = MarvelLisNavigationBuilder(coordinator: coordinator)
        return view
    }
}
