class JsonAction_Screens_OpenV1: JsonAction {
    override func silentExecute() -> Bool {
        screen.nav.pop().done()
        return true
    }
}

class JsonAction_Screens_CloseV1: JsonAction {
    override func silentExecute() -> Bool {
        screen.nav.pop().done()
        return true
    }
}

class JsonAction_Screens_CloseAllV1: JsonAction {
    override func silentExecute() -> Bool {
        screen.nav.backToHome().done()
        JsonAction.execute(spec: self.spec["onClose"], screen: self.screen, creator: self)
        return true
    }
}
