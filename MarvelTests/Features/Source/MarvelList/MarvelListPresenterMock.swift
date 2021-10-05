import Foundation
import UIKit
@testable import Marvel

class MarvelListPresenterMock: MarvelListPresenterContract {
    var navigationBuilder: MarvelLisNavigationBuilderContract?

    var view: MarvelListViewContract?

    func numberOfRowsIn(section: Int) -> Int {
        return 0
    }

    func viewModelAt(indexPath: IndexPath) -> MarvelCharacterCellViewModel? {
        return nil
    }

    func didSelectRowAt(indexPath: IndexPath) { }

    func didCollectionViewScrollToEnd() { }
}
