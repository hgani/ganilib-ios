import GaniLib

class JsonView_Panels_ListV1: JsonView {
    private let tableView = GTableView().width(.matchParent).height(.matchParent)
    
    override func initView() -> UIView {
        let delegate = Delegate(listView: self)
        
        tableView
            //            .withRefresher(screen.refresher)
            .autoRowHeight(estimate: 100)
            .delegate(delegate, retain: true)
            .source(delegate)
            .reloadData()
        
        return tableView
    }
    
    class Delegate: NSObject, UITableViewDataSource, UITableViewDelegate {
        private let listView: JsonView_Panels_ListV1
        private let sections: [Json]
        
        init(listView: JsonView_Panels_ListV1) {
            self.listView = listView
            self.sections = listView.spec["sections"].arrayValue
        }
        
        public func numberOfSections(in tableView: UITableView) -> Int {
            return sections.count
        }
        
        private func rows(at section: Int) -> [Json] {
            return sections[section]["rows"].arrayValue
        }
        
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return rows(at: section).count
        }
        
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let row = rows(at: indexPath.section)[indexPath.row]
            if let template = JsonTemplate.create(tableView: listView.tableView, spec: row, screen: listView.screen) {
                return template.createCell()
            }
            return GTableViewCell()
        }
        
        public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let row = rows(at: indexPath.section)[indexPath.row]
            JsonAction.executeAll(spec: row["onClick"], screen: listView.screen)
        }
    }
}

