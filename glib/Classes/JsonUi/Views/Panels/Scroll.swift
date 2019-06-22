class JsonView_Panels_ScrollV1: JsonView {
    private let panel = GScrollPanel()

    override func initView() -> UIView {
        // NOTE: subviews property is deprecated
        let childViews = spec["subviews"].array ?? spec["childViews"].arrayValue
        for viewSpec in childViews {
            if let jsonView = JsonView.create(spec: viewSpec, screen: screen) {
                panel.addView(jsonView.createView())
            }
        }
        return panel
    }
}
