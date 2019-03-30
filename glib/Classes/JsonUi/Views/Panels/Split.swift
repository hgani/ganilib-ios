class JsonView_Panels_SplitV1: JsonView {
    private let panel = GSplitPanel().width(.matchParent)

    override func initView() -> UIView {
        let content = spec["content"]
        if let center = content["center"].presence {
            return panel.withViews(
                createSubview(content["left"], center: false),
                createSubview(center, center: true),
                createSubview(content["right"], center: false)
            )
        } else {
            return panel.withViews(
                left: createSubview(content["left"], center: false),
                right: createSubview(content["right"], center: false)
            )
        }
    }

    private func createSubview(_ subviewSpec: Json, center: Bool) -> UIView {
        if subviewSpec.isNull {
            return GView().width(0)
        }

        let view = JsonView.create(spec: subviewSpec, screen: screen)?.createView() ?? UIView()
        if center, let iview = view as? IView {
            // Make sure the center view doesn't stretch up until the right of the container.
            // Let the split view stretch it only up until the left of the right component.
            iview.width(.wrapContent)
        }
        return view
    }
}
