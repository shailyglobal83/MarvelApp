@testable import Marvel

class MarvelListViewMock: MarvelListViewContract {
    var viewState: MarvelListViewState?
    var presenter: MarvelListPresenterContract!

    func changeState(state: MarvelListViewState) {
        viewState = state
    }
}
