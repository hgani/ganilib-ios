class JsonView_LabelV1: JsonView {
    private let label = GLabel()

    override func initView() -> UIView {
        if let text = spec["text"].string {
            _ = label.text(text)
        }
        if let align = spec["textAlign"].string {
            switch align {
            case "center":
                label.align(.center)
            case "right":
                label.align(.right)
            default:
                label.align(.left)
            }
        }

        return label
    }
}
