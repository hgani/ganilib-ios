
import UIKit

open class GImageView : UIImageView {
    public func namedImage(_ name: String) -> Self {
        self.image = UIImage(named: name)
        return self
    }
    
    public func adjustHeight() {
        if let i = image {
            layoutIfNeeded();
            
            let ratio = i.size.width / i.size.height;
            let height = self.frame.width / ratio
            
            NSLog("Adjusting to height: \(height)")
            
            self.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(height)
            }
        }
    }
}
