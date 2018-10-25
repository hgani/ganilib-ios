class JsonView_Panels_ScrollV1: JsonView {
    private let panel = GScrollPanel()

    override func initView() -> UIView {
        for viewSpec in spec["subviews"].arrayValue {
            if let jsonView = JsonView.create(spec: viewSpec, screen: screen) {
                panel.addView(jsonView.createView())
            }
        }
        return panel
    }
}
