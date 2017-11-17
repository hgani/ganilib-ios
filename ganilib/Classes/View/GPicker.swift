import UIKit

open class GPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    private var data = [String]()

    public init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        self.dataSource = self
        self.delegate = self
    }
    
    public func dataArray(_ data : [String]) -> GPicker {
        self.data = data
        return self
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {        
        return self.data[row]
    }
}
