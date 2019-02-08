open class JsonView_Panels_ListV1: JsonView {
    private let tableView = GTableView().width(.matchParent).height(.matchParent)

    open override func initView() -> UIView {
        let delegate = Delegate(view: self)

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
        private var sections: [Json]
        private var nextUrl: String?
        private var autoLoad = false

        init(view: JsonView_Panels_ListV1) {
            listView = view
            sections = listView.spec["sections"].arrayValue
            super.init()

            initNextPage(spec: listView.spec)
        }

        private func initNextPage(spec: Json) {
            if let nextPage = spec["nextPage"].presence {
                nextUrl = nextPage["url"].string
                autoLoad = nextPage["autoLoad"].boolValue
            } else {
                autoLoad = false
            }
        }

        public func numberOfSections(in _: UITableView) -> Int {
            return sections.count
        }

        private func rows(at section: Int) -> [Json] {
            return sections[section]["rows"].arrayValue
        }

        public func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
            return rows(at: section).count
        }

        public func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let row = rows(at: indexPath.section)[indexPath.row]
            if let template = JsonTemplate.create(tableView: listView.tableView, spec: row, screen: listView.screen) {
                return template.createCell()
            }
            return GTableViewCell()
        }

        public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
            let row = rows(at: indexPath.section)[indexPath.row]
            JsonAction.execute(spec: row["onClick"], screen: listView.screen, creator: nil)
        }

        func tableView(_ tableView: UITableView, willDisplay _: UITableViewCell, forRowAt indexPath: IndexPath) {
            let items = rows(at: indexPath.section)

            if autoLoad, indexPath.section == sections.count - 1, indexPath.row == items.count - 1, let url = self.nextUrl {
                _ = Rest.get(url: url).execute { response in
                    let result = response.content

                    self.initNextPage(spec: result)

                    for section in result["sections"].arrayValue {
                        self.sections.append(section)
                    }
                    tableView.reloadData()
                    return true
                }
            }
        }
    }
}
