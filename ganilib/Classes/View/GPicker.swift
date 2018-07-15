import UIKit

open class GPicker: UIPickerView, IView {
    private var helper: ViewHelper!
    private var data = [String]()
    private var onSelect: ((GDatePicker) -> Void)?
    public let header = GHorizontalPanel()

    public var size: CGSize {
        get {
            return helper.size
        }
    }
    
    public init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        self.helper = ViewHelper(self)

        self.dataSource = self
        self.delegate = self
        
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
    
    public func color(bg: UIColor?) -> Self {
        if let bgColor = bg {
            self.backgroundColor = bgColor
        }
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
    
    public func dataArray(_ data : [String]) -> GPicker {
        self.data = data
        return self
    }
    
}



extension GPicker: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
}

extension GPicker: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.data[row]
    }
}
