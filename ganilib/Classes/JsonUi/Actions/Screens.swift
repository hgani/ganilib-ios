import GaniLib

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
