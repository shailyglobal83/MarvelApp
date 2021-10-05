import Kingfisher
import UIKit

final class MarvelListCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var marvelThumbnailImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!

    func setup(model: MarvelCharacterCellViewModel?) {
        guard let model = model else {
            return
        }
        let placeHolder = UIImage(named: "placeholder")
        nameLabel.text = model.name
        marvelThumbnailImageView.kf.indicatorType = .activity
        marvelThumbnailImageView.kf.setImage(with: model.imageURL,
                                             placeholder: placeHolder,
                                             options: nil,
                                             completionHandler: nil)
    }
}
