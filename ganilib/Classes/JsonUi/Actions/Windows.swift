class JsonAction_Windows_OpenV1: JsonAction {
    override func silentExecute() -> Bool {
        nav.push(JsonUiScreen(url: spec["url"].stringValue))
        return true
    }
}

class JsonAction_Windows_CloseV1: JsonAction {
    override func silentExecute() -> Bool {
        nav.pop().done()
        return true
    }
}

class JsonAction_Windows_CloseAllV1: JsonAction {
    override func silentExecute() -> Bool {
        nav.backToHome().done()
        JsonAction.execute(spec: spec["onClose"], screen: screen, creator: self)
        return true
    }
}
