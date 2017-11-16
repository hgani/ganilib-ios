
import UIKit

public protocol ScreenProtocol: class {
    var navigationController: UINavigationController? { get }
    var controller: UIViewController { get }
    
    func onRefresh()
}
