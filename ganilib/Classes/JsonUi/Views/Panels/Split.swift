class JsonView_Panels_SplitV1: JsonView {
    private let panel = GSplitPanel()
    
    override func initView() -> UIView {
        let content = spec["content"]
        return panel.withViews(
            createSubview(content["left"]),
            createSubview(content["center"]),
            createSubview(content["right"]))
    }
    
    private func createSubview(_ subviewSpec: Json) -> UIView {
        if subviewSpec.null != nil {
            return UIView()
        }
        return JsonView.create(spec: subviewSpec, screen: screen)?.createView() ?? UIView()
    }
}
