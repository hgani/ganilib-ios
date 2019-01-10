class JsonView_H1V1: JsonView {
    private let label = GLabel().font(nil, size: 18, traits: .traitBold)

    override func initView() -> UIView {
        if let text = spec["text"].string {
            _ = label.text(text)
        }

        return label
    }
}
