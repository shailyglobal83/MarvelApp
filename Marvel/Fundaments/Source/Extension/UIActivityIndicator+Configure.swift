import Foundation
import UIKit

extension UIActivityIndicatorView {
    func configure(color: UIColor = .black) {
        self.color = color
        self.style = .large
        self.hidesWhenStopped = true
    }
}
