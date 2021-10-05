import Foundation

final class CharacterDetailsBuilder {
    let view: CharacterDetailsViewContract
    let presenter: CharacterDetailsPresenterContract

    init(view: CharacterDetailsViewContract = CharacterDetailsViewController.instantiate(),
         presenter: CharacterDetailsPresenterContract = CharacterDetailsPresenter()) {
        self.view = view
        self.presenter = presenter
    }

    func build(id: Int) -> CharacterDetailsViewContract {
        view.presenter = presenter
        presenter.view = view
        presenter.id = id
        return view
    }
}
