import Foundation
import UIKit

protocol StoryboardIdentifiable {
    associatedtype T

    static var identifier: String { get }
    static var storyboardName: String { get }
    static func instantiate() -> T
}

