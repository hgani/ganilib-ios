class JsonView_AbstractTextV1: JsonView, SubmittableField {
    private let view = GTextField()
   
    var name: String?
    var value: String {
        get {
            return view.text ?? ""
        }
    }
    
    override func initView() -> GTextField {
        self.name = spec["name"].string
        
        view.placeholder = spec["label"].string
        view.text = spec["value"].string
        
        initBottomBorder()
        
        return view
    }
    
    private func initBottomBorder() {
        view.borderStyle = .none
        view.layer.backgroundColor = UIColor.white.cgColor
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 0.0
    }
}
