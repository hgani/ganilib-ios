import UIKit

open class GDatePicker: UIDatePicker {
    private var helper: ControlHelper<GDatePicker>!
//    private var helper: ViewHelper!
//    private var onSelect: ((GDatePicker) -> Void)?

    public var size: CGSize {
        return helper!.size
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
        helper = ControlHelper(self)

        // Make sure that contentEdgeInsets' values is always initialized properly (i.e. non-zero)
//        _ = self.paddings(t: 10, l: 20, b: 10, r: 20)
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

    public func onSelect(_ command: @escaping (GDatePicker) -> Void) -> Self {
        _ = helper.onSelect(command)
        return self
    }

    public func color(bg: UIColor) -> Self {
        return color(bg: bg, text: nil)
    }

    public func color(bg: UIColor?, text: UIColor? = nil) -> Self {
        if let bgColor = bg {
            backgroundColor = bgColor
        }
        if let textColor = text {
            setValue(textColor, forKeyPath: "textColor")
        }
        return self
    }

    public func mode(_ mode: UIDatePickerMode) -> Self {
        datePickerMode = mode
        return self
    }

//
//    public func border(color : UIColor?, width : Float = 1, corner : Float = 6) -> Self {
//        helper.border(color: color, width: width, corner: corner)
//        return self
//    }
//
//    public func enabled(_ value : Bool) -> Self {
//        self.isEnabled = value
//        self.alpha = value ? 1.0 : 0.5
//        return self
//    }

    public func done() {
        // End chaining
    }
}

// extension GDatePicker: UIPickerViewDelegate {
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        if pickerView.tag == 2, component == 1 {
//            //if the hours worked is greater than 4 hours plus 30 minute break
//            if let totalMins = self.entry.totalMinutesWorked?.doubleValue,
//                totalMins > (4.5 * 60) {
//                let hours: Int   = pickerView.selectedRow(inComponent: 0)
//                let minutes: Int = pickerView.selectedRow(inComponent: 1)
//                //dont let em scroll to less than 30 mins if 0 hours
//                if hours == 0 && minutes < 6 {
//                    pickerView.selectRow(6, inComponent: 1, animated: true)
//                }
//            }
//        }
//
//
//        if component == 0 {
//            print("selected \(row) hours")
//        } else if component == 1 {
//            print("selected \((row+1) * 5) minutes")
//        }
//
//        let hours: Int   = pickerView.selectedRow(inComponent: 0)
//        let minutes: Int = pickerView.selectedRow(inComponent: 1)
//
//        self.sections[pickerView.tag].didPick = true
//        self.sections[pickerView.tag].headerView?.timeLabel.text = "\(hours) hrs \(minutes * 5) mins"
//        self.sections[pickerView.tag].headerView?.timeLabel.isHidden = false
//        self.sections[pickerView.tag].headerView?.addButton.isHidden = true
//
//        var totalMinutes: Int = 0
//        totalMinutes += hours   * 60
//        totalMinutes += minutes * 5
//        self.entry.breakMinutes = NSNumber(value: totalMinutes)
//
//        self.updateTotalHours()
//    }
// }
