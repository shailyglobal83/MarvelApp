import UIKit

protocol CharacterDetailsViewContract: AnyObject {
    var presenter: CharacterDetailsPresenterContract! { get set }

    func changeState(state: CharacterDetailsViewState)
}

final class CharacterDetailsViewController: BaseViewController {
    var presenter: CharacterDetailsPresenterContract!
    @IBOutlet private weak var noDataLabel: UILabel!
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var characterDetailLabel: UILabel!
    @IBOutlet private weak var characterNameLabel: UILabel!

    override static var storyboardName: String {
        "CharacterDetailsView"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }

    private func setup(model: CharacterDetailsViewModel) {
        noDataLabel.text = "no_description".localized
        characterDetailLabel.text = model.descriptionText
        noDataLabel.isHidden = !model.descriptionText.isEmpty
        characterDetailLabel.isHidden = model.descriptionText.isEmpty
        characterNameLabel.text = model.name
        characterImageView.kf.indicatorType = .activity
        characterImageView.kf.setImage(with: model.thumbnailURL,
                                       placeholder: UIImage(),
                                       options: nil,
                                       completionHandler: nil)
    }

    private func handleError() {
        noDataLabel.text = "error_message".localized
        noDataLabel.isHidden = false
    }
}

extension CharacterDetailsViewController: CharacterDetailsViewContract {
    func changeState(state: CharacterDetailsViewState) {
        switch state {
        case .render(let model):
            removeLoader()
            setup(model: model)
        case .loading:
            addLoader()
        case .error:
            removeLoader()
            handleError()
        case .loadView: break
        }
    }
}
