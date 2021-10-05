import Foundation

protocol MarvelLisNavigationBuilderContract {
    func navigateToMarvelDetails(id: Int)
}

final class MarvelLisNavigationBuilder: MarvelLisNavigationBuilderContract {
    var coordinator: MainCoordinatorContract?

    init(coordinator: MainCoordinatorContract?) {
        self.coordinator = coordinator
    }

    func navigateToMarvelDetails(id: Int) {
        guard let coordinator = coordinator else {
            return
        }
        coordinator.navigateToCharacterDetail(id: id)
    }
}
