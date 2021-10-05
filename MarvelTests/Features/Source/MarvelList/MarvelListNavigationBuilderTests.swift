import XCTest
@testable import Marvel

class MarvelListNavigationBuilderTests: XCTestCase {

    let coordinatorMock = CoordinatorMock()
    private var builder: MarvelLisNavigationBuilder!

    func testNavigateToMarvelDetails() {
        builder = MarvelLisNavigationBuilder(coordinator: coordinatorMock)
        builder.navigateToMarvelDetails(id: 123)
        XCTAssertTrue(coordinatorMock.navigateToDetailCalled)
    }
}
