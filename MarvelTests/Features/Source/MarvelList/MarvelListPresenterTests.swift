import Foundation
import XCTest
@testable import Marvel

class MarvelListPresenterTests: XCTestCase {
    
    var presenter: MarvelListPresenter!
    var mockView: MarvelListViewMock = MarvelListViewMock()
    var presenterUseCaseMock = MarvelListUseCaseMock()
    var navigationBuilderMock = MarvelListNavigationBuilderMock()

    override func setUp() {
        super.setUp()
        presenter = MarvelListPresenter(marvelListUseCase: presenterUseCaseMock)
        presenter.view = mockView
        presenter.navigationBuilder = navigationBuilderMock
        mockView.presenter = presenter
    }

    func testGetMarvelListSuccess() {
        presenterUseCaseMock.result = .success(MarvelListModel.dummyInstance())
        presenter.viewLoaded()
        XCTAssertEqual(mockView.viewState, .render)
    }

    func testGetMarvelListFailure() {
        presenterUseCaseMock.result = .failure(.noData)
        presenter.viewLoaded()
        XCTAssertEqual(mockView.viewState, .error)
    }

    func testNumberOfRows() {
        presenterUseCaseMock.result = .success(MarvelListModel.dummyInstance())
        presenter.viewLoaded()
        XCTAssertEqual(presenter.numberOfRowsIn(section: 0), 1)
    }

    func testViewModelAtIndex() {
        presenterUseCaseMock.result = .success(MarvelListModel.dummyInstance())
        presenter.viewLoaded()
        XCTAssertNotNil(presenter.viewModelAt(indexPath: IndexPath(row: 0, section: 0)))
    }

    func testDidSelectRowAt() {
        presenterUseCaseMock.result = .success(MarvelListModel.dummyInstance())
        presenter.viewLoaded()
        presenter.didSelectRowAt(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertTrue(navigationBuilderMock.navigateToMarvelDetailsCalled)
    }

    func testDidCollectionViewScrollToEnd() {
        presenterUseCaseMock.result = .success(MarvelListModel.dummyInstance())
        presenter.didCollectionViewScrollToEnd()
        XCTAssertEqual(mockView.viewState, .render)
    }
}
