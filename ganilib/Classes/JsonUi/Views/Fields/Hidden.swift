class JsonView_Fields_HiddenV1: JsonView_AbstractTextV1 {
    override func initView() -> UITextField {
        return super.initTextField().width(0).height(0)
    }
}
