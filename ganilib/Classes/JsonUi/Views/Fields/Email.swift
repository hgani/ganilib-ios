class JsonView_Fields_EmailV1: JsonView_AbstractTextV1 {
    override func initView() -> UITextField {
        return super.initTextField().keyboardType(.emailAddress)
    }
}
