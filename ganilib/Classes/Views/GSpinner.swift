
import UIKit

open class GSpinner : GButton {
    private var screen : GScreen?  // Nil if instantiated from NSCoder
//    private var data = [String: String]()
//    private var values = [String]()
    
    private var data = [AnyObject]()
    private var selectedItem : AnyObject?
    
    public init(_ screen: GScreen) {
        self.screen = screen
        
        super.init()
        
        addTarget(self, action: #selector(openOptionSheet), for: .touchUpInside)
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    public func dataDictionary(_ data : [String: String], sortedKeys: [String]) -> GSpinner {
//        self.data = data
//        self.values = sortedKeys
//        
////        if value = values[0] {
////            _ = title(value)
////        }
//        
//        if values.count > 0 {
//            _ = title(values[0])
//        }
//        
//        return self
//    }
    
    public func data(_ data : [AnyObject]) -> GSpinner {
//        var dict = [String: String]()
//        for value in data {
//            dict[value] = value
//        }
//        return dataDictionary(dict)
        
        self.data = data
        
        if data.count > 0 {
            self.selectedItem = data[0]
            updateLabel()
            //_ = title(values[0])
        }
        return self
    }
    
    private func updateLabel() {
        if let item = selectedItem {
            _ = title(item.description)
        }
    }
    
    func openOptionSheet() {
        let alert = UIAlertController(title: nil, message: "Choose Distance", preferredStyle: .actionSheet)
        
        for (index, obj) in data.enumerated() {
            let title = obj.description
            let action = UIAlertAction(title: title,
                                       style: .default,
                                       handler: { (action) in
                                        if self.title(for: .normal) != title {
                                            //self.button.setTitle(title, for: .normal)
                                            self.selectedItem = self.data[index]
                                            self.updateLabel()
                                            
                                            //self.selectedDistances = option["value"] as! Double
                                            //self.updateMapDistance()
                                        }
            })
            alert.addAction(action)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        screen?.present(alert, animated: true)
        
//        screen.present(alert, animated: true, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
//        navigationController?.present(alert, animated: true, completion: nil)
//        let app = UIApplication.shared.delegate
//        app.navigation
//        [del.navigationController pushViewController:nextViewController animated:YES];
        
        //self.window?.rootViewController.push
    }
    
    
//
//    public func title(_ title : String, icon: Ionicons? = nil) -> GSpinner {
//        let callButtonString = NSMutableAttributedString()
//        
//        if icon != nil {
//            let callIcon = String.ionicon(with: icon!)
//            let callIconAttributed = NSMutableAttributedString(string: callIcon, attributes: [NSFontAttributeName: UIFont.ionicon(of: 20)])
//            callButtonString.append(callIconAttributed)
//        }
//        
//        let callStringAttributed = NSMutableAttributedString(string: title, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
//        callButtonString.append(callStringAttributed)
//        
//        self.setAttributedTitle(callButtonString, for: .normal)
//        
//        self.layer.cornerRadius = 4
//        
//        return self
//    }
}
