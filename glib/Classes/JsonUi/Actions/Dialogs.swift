class JsonAction_Dialogs_AlertV1: JsonAction {
    override func silentExecute() -> Bool {
        guard let message = spec["message"].string else {
            return false
        }

        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            JsonAction.execute(spec: self.spec["onClose"], screen: self.screen, creator: self)
        }))
        screen.present(alert, animated: true, completion: nil)

        return true
    }
}
