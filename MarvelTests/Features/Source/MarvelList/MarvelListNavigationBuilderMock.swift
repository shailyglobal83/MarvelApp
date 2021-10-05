import Foundation

@testable import Marvel

class MarvelListNavigationBuilderMock: MarvelLisNavigationBuilderContract {
    var navigateToMarvelDetailsCalled = false

    func navigateToMarvelDetails(id: Int) {
        navigateToMarvelDetailsCalled = true
    }
}
