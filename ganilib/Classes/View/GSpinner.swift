
import UIKit

open class GSpinner<T> : GButton {
    private var screen : GScreen?  // Nil if instantiated from NSCoder

    private var data = [T]()
    public private(set) var selectedItem : T?
    private var onItemSelected : ((T) -> Void)?
    
    public init(_ screen: GScreen) {
        self.screen = screen
        
        super.init()
        
        addTarget(self, action: #selector(showOptions), for: .touchUpInside)
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func data(_ data : [T]) -> Self {
        self.data = data
        
        if data.count > 0 {
            self.selectedItem = data[0]
            updateLabel()
        }
        return self
    }
    
    private func label(_ item : T) -> String {
        switch item {
        case let str as String:
            return str
        case let obj as NSObject:
            return obj.description
        default:
            return ""
        }

    }
    
    private func updateLabel() {
        if let item = selectedItem {
            _ = title(label(item))
        }
    }
    
    func showOptions() {
        let alert = UIAlertController(title: nil, message: "Choose Distance", preferredStyle: .actionSheet)
        
        for (index, obj) in data.enumerated() {
            let title = label(obj)
            let action = UIAlertAction(
                title: title,
                style: .default,
                handler: { (action) in
                    if self.title(for: .normal) != title {
                        self.selectedItem = self.data[index]
                        self.updateLabel()
                        
                        if let callback = self.onItemSelected {
                            callback(self.selectedItem!)
                        }
                    }
                })
            alert.addAction(action)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        screen?.present(alert, animated: true)
    }
    
    // Use block instead of selector from now on. See https://stackoverflow.com/questions/24007650/selector-in-swift
    public func onItemSelected(_ command: @escaping (T) -> Void) -> Self {
        self.onItemSelected = command
        return self
    }
    
    // NOTE: Deprecated. Use property instead.
    public func getSelectedItem() -> T? {
        return selectedItem
    }
}
