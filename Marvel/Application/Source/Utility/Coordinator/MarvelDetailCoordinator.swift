import Foundation
import UIKit

class MarvelDetailCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

    var navigationController: UINavigationController
    var id: Int

    init(navigationController: UINavigationController, id: Int) {
        self.navigationController = navigationController
        self.id = id
    }

    func start() {
        guard let characterDetailsViewController = CharacterDetailsBuilder().build(id: id) as? CharacterDetailsViewController else {
            return
        }
        navigationController.pushViewController(characterDetailsViewController, animated: true)
    }
}
