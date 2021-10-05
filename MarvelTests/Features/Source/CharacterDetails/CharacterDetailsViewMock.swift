@testable import Marvel

class CharacterDetailsViewMock: CharacterDetailsViewContract {
    var viewState: CharacterDetailsViewState?
    var presenter: CharacterDetailsPresenterContract!

    func changeState(state: CharacterDetailsViewState) {
        viewState = state
    }
}
