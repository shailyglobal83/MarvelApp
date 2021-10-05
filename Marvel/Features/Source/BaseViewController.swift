import UIKit

class BaseViewController: UIViewController, StoryboardIdentifiable {
    private let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.configure()
        addConstraintsForActivityIndicator()
    }

    open class var storyboardName: String {
        assertionFailure("Need to override storyboard name")
        return ""
    }
}

extension BaseViewController {
    private func addConstraintsForActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicator.isHidden = true
    }

    func addLoader() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    func removeLoader() {
        activityIndicator.stopAnimating()
    }
}
