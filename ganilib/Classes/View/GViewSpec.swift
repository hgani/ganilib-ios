
import UIKit

public protocol GViewSpec {
    associatedtype V
    func initialize(_ view: V)
}
