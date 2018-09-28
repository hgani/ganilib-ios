class JsonView_Panels_FormV1: JsonView {
    private let panel = FormPanel()
    
//    required init(_ spec: Json, _ screen: GScreen) {
//        panel = FormPanel(jsonView: self)
//        super.init(spec, screen)
//    }
    
    override func initView() -> UIView {
        panel.jsonView = self
        
        for viewSpec in spec["subviews"].arrayValue {
            if let jsonView = JsonView.create(spec: viewSpec, screen: screen) {
                panel.addView(jsonView.createView(), top: 10)
                
                // NOTE: Currently we assume all fields are direct children.
                
                if let field = jsonView as? SubmittableField {
                    panel.addField(field)
                }
            }            
        }
        return panel
    }
    
    
    
    class FormPanel: GVerticalPanel {
        fileprivate var jsonView: JsonView_Panels_FormV1!
        
        private var fields = [SubmittableField]()
        
//        init(jsonView: JsonView_Panels_FormV1) {
//            self.jsonView = jsonView
//        }
//
//        required init?(coder aDecoder: NSCoder) {
//            fatalError("Unsupported")
//        }

        fileprivate func addField(_ field: SubmittableField) {
            fields.append(field)
        }
        
        func submit() {
            var params = GParams()
            for field in fields {
                if let name = field.name {
                    params[name] = field.value
                }
            }
            
            let spec = jsonView.spec
            let screen = jsonView.screen
            _ = Rest.from(method: spec["method"].stringValue, url: spec["url"].stringValue, params: params)?.execute { response in
//                // Support generic uncustomizable framework (e.g. Devise).
//                if let error = result["error"].string {
//                    screen.launch.alert(error)
//                }
                JsonAction.execute(spec: response.content["onResponse"], screen: screen, creator: self)
                return true
            }
        }
    }
}
