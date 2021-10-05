import XCTest
@testable import Marvel

class CharacterDetailsBuilderTests: XCTestCase {

    private let presenterMock = CharacterDetailsPresenterMock()
    private let mockView = CharacterDetailsViewMock()
    private var builder: CharacterDetailsBuilder!

    func testBuild() {
        builder = CharacterDetailsBuilder(view: mockView,
                                          presenter: presenterMock)
        let view = builder.build(id: 123)
        XCTAssertNotNil(presenterMock.view)
        XCTAssertNotNil(view.presenter)
    }
}
