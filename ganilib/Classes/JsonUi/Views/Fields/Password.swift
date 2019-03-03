class JsonView_Fields_PasswordV1: JsonView_AbstractTextV1 {
    override func initView() -> UITextField {
        return super.initTextField().secure(true)
    }
}
