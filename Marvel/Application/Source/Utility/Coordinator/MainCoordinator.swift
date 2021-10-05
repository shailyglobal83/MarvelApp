import Foundation
import UIKit

protocol MainCoordinatorContract: Coordinator {
    func navigateToCharacterDetail(id: Int)
}

class MainCoordinator: MainCoordinatorContract {
    var childCoordinators = [Coordinator]()

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let builder = MarvelListBuilder()
        builder.coordinator = self
        guard let marvelListController = builder.build() as? MarvelListViewController else {
            return
        }
        navigationController.pushViewController(marvelListController, animated: false)
    }

    func navigateToCharacterDetail(id: Int) {
        let detailCoordinator = MarvelDetailCoordinator(navigationController: navigationController, id: id)
        childCoordinators.append(detailCoordinator)
        detailCoordinator.start()
    }
}
