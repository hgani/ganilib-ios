class JsonAction_Forms_SubmitV1: JsonAction {
    override func silentExecute() -> Bool {
        var ancestor = targetView?.superview
        while ancestor != nil && !(ancestor is JsonView_Panels_FormV1.FormPanel) {
            ancestor = ancestor?.superview
        }
        (ancestor as? JsonView_Panels_FormV1.FormPanel)?.submit()
        return true
    }
}
