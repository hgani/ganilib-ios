import UIKit

open class GPicker: UIPickerView, IView {
    private var helper: ViewHelper!
    private var data = [String]()
    private var onSelect: ((GDatePicker) -> Void)?
    public let header = GHorizontalPanel()

    public var size: CGSize {
        return helper.size
    }

    public init() {
        super.init(frame: .zero)
        initialize()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize() {
        helper = ViewHelper(self)

        dataSource = self
        delegate = self

        addSubview(header)

        header.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
        }
    }

    public func source(_ dataSource: UIPickerViewDataSource) -> Self {
        self.dataSource = dataSource
        return self
    }

    public func delegate(_ delegate: UIPickerViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }

    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }

    public func width(_ width: Int) -> Self {
        helper.width(width)
        return self
    }

    public func width(_ width: LayoutSize) -> Self {
        helper.width(width)
        return self
    }

    public func width(weight: Float, offset: Float = 0) -> Self {
        helper.width(weight: weight, offset: offset)
        return self
    }

    public func height(_ height: Int) -> Self {
        helper.height(height)
        return self
    }

    public func height(_ height: LayoutSize) -> Self {
        helper.height(height)
        return self
    }

    public func color(bg: UIColor) -> Self {
        backgroundColor = bg
        return self
    }

    public func paddings(top: Float?, left: Float?, bottom: Float?, right: Float?) -> Self {
        helper.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }

//    public func onSelect(_ command: @escaping (GDatePicker) -> Void) -> Self {
//        helper.onSelect(command)
//        return self
//    }

//    public func onSelect(_ command: @escaping (GPicker) -> Void) -> Self {
//                self.onSelect = command
//                addTarget(self, action: #selector(performSelect), for: .valueChanged)
//        return self
//    }
//
//    @objc open func performSelect() {
//        if let callback = self.onSelect {
//            callback(self)
//        }
//    }

    public func dataArray(_ data: [String]) -> GPicker {
        self.data = data
        return self
    }
}

extension GPicker: UIPickerViewDataSource {
    public func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        return data.count
    }
}

extension GPicker: UIPickerViewDelegate {
    public func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        return data[row]
    }
}
