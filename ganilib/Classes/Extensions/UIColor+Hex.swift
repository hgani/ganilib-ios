import UIKit

public extension UIColor {
    convenience init(hex hexString: String) {
        let red, green, blue, alpha: CGFloat

        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            // var hexColor = hexString.substring(from: start)
            var hexColor = String(hexString[start...])

            if hexColor.count == 6 {
                hexColor += "ff"
            }

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    red = CGFloat((hexNumber & 0xFF00_0000) >> 24) / 255
                    green = CGFloat((hexNumber & 0x00FF_0000) >> 16) / 255
                    blue = CGFloat((hexNumber & 0x0000_FF00) >> 8) / 255
                    alpha = CGFloat(hexNumber & 0x0000_00FF) / 255

                    self.init(red: red, green: green, blue: blue, alpha: alpha)
                    return
                }
            }
        }
        self.init(red: 0, green: 0, blue: 0, alpha: 0)
    }
}
