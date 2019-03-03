class JsonView_Panels_HorizontalV1: JsonView {
    private let panel = GHorizontalPanel()

    override func initView() -> UIView {
        let subviews: [UIView] = spec["subviews"].arrayValue.compactMap { viewSpec -> UIView? in
            if let jsonView = JsonView.create(spec: viewSpec, screen: screen) {
                return jsonView.createView()
            }
            return nil
        }

        switch spec["distribution"].stringValue {
        case "fillEqually":
            for view in subviews {
                panel.addView(view)
            }
            panel.split()
        case "spaceEqually":
            for view in subviews {
                panel.addView(GAligner().align(.top).withView(view))
            }
            panel.split()
        default:
            for view in subviews {
                panel.addView(view)
            }
        }
        return panel
    }
}
