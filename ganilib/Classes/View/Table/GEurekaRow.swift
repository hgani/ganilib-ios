// Causes "segmentation fault" during compilation on xcode 10.
//#if INCLUDE_EUREKA
//
//import UIKit
//import Eureka
//
//open class _EurekaRow<Cell: CellType>: Row<Cell> where Cell: BaseCell {
//    open var presentationMode: PresentationMode<UIViewController>?
//
//    public required init(tag: String?) {
//        super.init(tag: tag)
//    }
//
//    open override func customDidSelect() {
//        super.customDidSelect()
//
//        if !isDisabled {
//            if let presentationMode = presentationMode {
//                if let controller = presentationMode.makeController() {
//                    presentationMode.present(controller, row: self, presentingController: self.cell.formViewController()!)
//                } else {
//                    presentationMode.present(nil, row: self, presentingController: self.cell.formViewController()!)
//                }
//            }
//        }
//    }
//}
//
//public final class GEurekaRow<T: Equatable, C: GEurekaCell<T>>: _EurekaRow<C>, RowType {
//    public required init(tag: String?) {
//        super.init(tag: tag)
//    }
//}
//
//open class GEurekaCell<T: Equatable>: Cell<T>, CellType {
//    //    private let container = GVerticalPanel().width(.matchParent).height(.matchParent).color(bg: .yellow)
//    private let container = GVerticalPanel()
//
//    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        initialize()
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        initialize()
//    }
//
//    private func initialize() {
//        self.contentView.addSubview(container)
//
//        container.snp.makeConstraints { (make) -> Void in
//            // Snap the panel's vertical edges so that the tableView can determine the dynamic height of each row
//            // See https://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights
//            make.top.equalTo(self.contentView)
//            make.bottom.equalTo(self.contentView)
//
//            make.left.equalTo(super.contentView)
//            make.right.equalTo(self.contentView)
//        }
//
//        initContent()
//    }
//
//    public func addView(_ view: UIView, top : CGFloat? = nil) {
//        container.addView(view, top: top)
//    }
//
//    open func initContent() {
//        // To be overridden
//    }
//
//    open override func update() {
//        accessoryType = .disclosureIndicator
//        editingAccessoryType = accessoryType
//        selectionStyle = row.isDisabled ? .none : .default
//    }
//}
//
//#endif
//
