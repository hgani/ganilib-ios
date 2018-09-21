class JsonView_Fields_PasswordV1: JsonView_AbstractTextV1 {
    override func initView() -> GTextField {
        return super.initView().secure(true)
    }
}
