class JsonAction_Screens_OpenV1: JsonAction {
    override func silentExecute() -> Bool {
        nav.pop().done()
        return true
    }
}

class JsonAction_Screens_CloseV1: JsonAction {
    override func silentExecute() -> Bool {
        nav.pop().done()
        return true
    }
}

class JsonAction_Screens_CloseAllV1: JsonAction {
    override func silentExecute() -> Bool {
        nav.backToHome().done()
        JsonAction.execute(spec: spec["onClose"], screen: screen, creator: self)
        return true
    }
}
