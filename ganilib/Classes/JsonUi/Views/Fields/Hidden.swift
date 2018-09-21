class JsonView_Fields_HiddenV1: JsonView_AbstractTextV1 {
    override func initView() -> GTextField {
        return super.initView().width(0).height(0)
//        view.isHidden = true
//        return view
    }
}
