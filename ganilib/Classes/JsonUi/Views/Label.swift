class JsonView_LabelV1: JsonView {
    private let label = GLabel()

    override func initView() -> UIView {
        if let text = spec["text"].string {
            _ = label.text(text)
        }
        return label
    }
}
