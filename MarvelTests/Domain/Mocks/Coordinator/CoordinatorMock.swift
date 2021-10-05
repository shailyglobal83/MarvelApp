@testable import Marvel
import UIKit

class CoordinatorMock: MainCoordinatorContract {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController = UINavigationController()
    var startCalled = false
    var navigateToDetailCalled = false

    func start() {
        startCalled = true
    }

    func navigateToCharacterDetail(id: Int) {
        navigateToDetailCalled = true
    }
}
