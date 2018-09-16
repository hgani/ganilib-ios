import GaniLib

class JsonAction_Utils_SetTimeoutV1: JsonAction {
    override func silentExecute() -> Bool {
        guard let interval = spec["interval"].double else {
            return false
        }
        Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
            JsonAction.executeAll(spec: self.spec["onTimeout"], screen: self.screen)
        }
        return true
    }
}
