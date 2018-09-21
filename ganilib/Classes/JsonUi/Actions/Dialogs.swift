class JsonAction_Dialogs_AlertV1: JsonAction {
    override func silentExecute() -> Bool {
        guard let message = spec["message"].string else {
            return false
        }
        screen.launch.alert(message)
        return true
    }
}
