//
//import UIKit
//
//open class GScrolleeView : UIView {
//    
//    // From http://stackoverflow.com/questions/3605393/iphone-uiview-resize-frame-to-fit-subviews
//    func resizeToFitSubviews() {
//        var width: CGFloat = 0
//        var height: CGFloat = 0
//        for someView in self.subviews {
//            NSLog("Size0: \(someView.frame.origin.x) + \(someView.frame.width)");
//
//            NSLog("Size1: \(someView.frame.origin.y) + \(someView.frame.height)");
//
//            //let aView = someView as! UIView
//            let newWidth = someView.frame.origin.x + someView.frame.width
//            let newHeight = someView.frame.origin.y + someView.frame.height
//            
//            NSLog("Size2: \(newWidth), \(newHeight)");
//
//            width = max(width, newWidth)
//            height = max(height, newHeight)
//            
//            NSLog("Size3: \(width), \(height)");
//
//        }
//        
//        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: width, height: height)
//    }
//    
//}
