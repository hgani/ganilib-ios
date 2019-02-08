class JsonView_Panels_HorizontalV1: JsonView {
    private let panel = GHorizontalPanel()
//    private let panel = GStackView()

    override func initView() -> UIView {
        let subviews: [UIView] = spec["subviews"].arrayValue.compactMap { viewSpec -> UIView? in
            if let jsonView = JsonView.create(spec: viewSpec, screen: screen) {
//                return panel.addView(jsonView.createView())
                return jsonView.createView()
            }
            return nil
        }
        
//        for viewSpec in spec["subviews"].arrayValue {
//            if let jsonView = JsonView.create(spec: viewSpec, screen: screen) {
//                panel.addView(jsonView.createView())
//            }
//        }

        switch spec["distribution"] {
        case "fillEqually":
            for view in subviews {
                panel.addView(view)
            }
            panel.width(.matchParent).color(bg: .red).split()
        case "spaceEqually":
            for view in subviews {
                panel.addView(GAligner().color(bg: .blue).withView(view))
            }
            panel.width(.matchParent).color(bg: .red).split()
        default:
            for view in subviews {
                panel.addView(view)
            }
        }
        return panel
    }
}
