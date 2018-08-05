
import UIKit

open class GTableViewRowAction: UITableViewRowAction {
    public func color(bg: UIColor?) -> Self {
        if let bgColor = bg {
            self.backgroundColor = bgColor
        }
        return self
    }
}
