class JsonView_Panels_HorizontalV1: JsonView {
    private let panel = GHorizontalPanel()

    override func initView() -> UIView {
        for viewSpec in spec["subviews"].arrayValue {
            if let jsonView = JsonView.create(spec: viewSpec, screen: screen) {
                panel.addView(jsonView.createView())
            }
        }
        return panel
    }
}
