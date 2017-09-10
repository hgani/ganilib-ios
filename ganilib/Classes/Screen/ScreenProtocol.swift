
import UIKit

public protocol ScreenProtocol {
    // We would have loved this to be in NavHelper but unfortunately it presents complexity because NavHelper
    // gets initialised asynchronously (in viewDidLoad()) so it doesn't exist in the beginning.
//    var previous: ScreenProtocol? { get set }
//    var nav : NavHelper! { get set }
    
    var title: String? { get set }
    var navigationController: UINavigationController? { get }
    
    func onRefresh()
}
