import XCTest
@testable import Marvel

class CharacterDetailsPresenterTests: XCTestCase {
    var presenter: CharacterDetailsPresenter!
    var mockView = CharacterDetailsViewMock()
    var useCaseMock = CharacterDetailsUseCaseMock()

    override func setUp() {
        super.setUp()
        presenter = CharacterDetailsPresenter(characterDetailsUseCase: useCaseMock)
        presenter.view = mockView
        mockView.presenter = presenter
        presenter.id = 123
    }

    func testGetCharacterDetailsSuccess() {
        useCaseMock.result = .success(CharacterDetailsModel.dummyInstance())
        presenter.viewLoaded()
        let expectedModel = CharacterDetailsViewModel(name: "Test Name",
                                                      descriptionText: "Testing",
                                                      thumbnailURL: URL(string: "www.testurl.com"))
        XCTAssertEqual(mockView.viewState, .render(expectedModel))
    }

    func testGetCharacterDetailsFailure() {
        useCaseMock.result = .failure(.noData)
        presenter.viewLoaded()
        XCTAssertEqual(mockView.viewState, .error)
    }
}
