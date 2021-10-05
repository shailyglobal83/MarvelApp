import XCTest
@testable import Marvel

class MarvelListBuilderTests: XCTestCase {

    private let presenterMock = MarvelListPresenterMock()
    private let mockView = MarvelListViewMock()
    private var builder: MarvelListBuilder!

    func testBuild() {
        builder = MarvelListBuilder(view: mockView,
                                    presenter: presenterMock)
        let view = builder.build()
        XCTAssertNotNil(presenterMock.view)
        XCTAssertNotNil(view.presenter)
    }
}
