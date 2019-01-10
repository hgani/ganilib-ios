class JsonView_Panels_SplitV1: JsonView {
    private let panel = GSplitPanel().width(.matchParent)

    override func initView() -> UIView {
        let content = spec["content"]
        return panel.withViews(
            createSubview(content["left"], stretch: false),
            createSubview(content["center"], stretch: true),
            createSubview(content["right"], stretch: false)
        )
    }

    private func createSubview(_ subviewSpec: Json, stretch: Bool) -> UIView {
        if subviewSpec.null != nil {
            if stretch {
                return GView()
            }
            return GView().width(0)
        }
        return JsonView.create(spec: subviewSpec, screen: screen)?.createView() ?? UIView()
    }
}
