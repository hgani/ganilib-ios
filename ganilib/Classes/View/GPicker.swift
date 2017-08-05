import UIKit

open class GPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    private var data = [String]()

    public init() {
        super.init(frame: .zero)
        
        self.dataSource = self
        self.delegate = self
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
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
        //NSLog("ROW: \(row) -- \(data[row])")
        
        return self.data[row]
    }
}
