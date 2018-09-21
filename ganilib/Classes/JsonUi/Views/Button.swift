class JsonView_ButtonV1: JsonView {
    private let view = GButton()
        .color(bg: nil, text: .darkGray)
        .border(color: .darkGray)
        .font(nil, size: 12)

    override func initView() -> UIView {
        if let text = spec["text"].string {
            _ = view.title(text)
        }
        _ = view.onClick { _ in
            JsonAction.execute(spec: self.spec["onClick"], screen: self.screen, creator: self.view)
        }
        return view
    }
}
