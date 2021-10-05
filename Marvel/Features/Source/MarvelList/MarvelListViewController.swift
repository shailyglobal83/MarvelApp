import UIKit

protocol MarvelListViewContract: AnyObject {
    var presenter: MarvelListPresenterContract! { get set }

    func changeState(state: MarvelListViewState)
}

final class MarvelListViewController: BaseViewController {
    @IBOutlet private weak var errorMessageLabel: UILabel!
    @IBOutlet private weak var marvelListCollectionView: UICollectionView!
    var presenter: MarvelListPresenterContract!

    override static var storyboardName: String {
        "MarvelList"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Marvel" 
        presenter.viewLoaded()
    }

    private func handleError() {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = "error_message".localized
    }
}

extension MarvelListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRowsIn(section: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                                String(describing: MarvelListCollectionViewCell.self),
                                                            for: indexPath) as? MarvelListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(model: presenter.viewModelAt(indexPath: indexPath))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width * 0.45, height: collectionView.frame.size.width * 0.45)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.numberOfRowsIn(section: indexPath.row) - 1 {
            presenter.didCollectionViewScrollToEnd()
        }
    }
}
extension MarvelListViewController: MarvelListViewContract {
    func changeState(state: MarvelListViewState) {
        switch state {
        case .render:
            removeLoader()
            errorMessageLabel.isHidden = true
            marvelListCollectionView.reloadData()
        case.loading: addLoader()
        case .error:
            removeLoader()
            handleError()
        case .loadView: break
        }
    }
}
