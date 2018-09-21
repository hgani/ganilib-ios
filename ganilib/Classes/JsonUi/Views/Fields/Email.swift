class JsonView_Fields_EmailV1: JsonView_AbstractTextV1 {
    override func initView() -> GTextField {
        return super.initView().keyboardType(.emailAddress)
    }
}
