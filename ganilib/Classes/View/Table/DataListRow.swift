#if INCLUDE_EUREKA
    import Eureka

    private protocol ConfigurableRow {
        var intro: String? { get }
    }

    open class _DataListRow<Cell: CellType>: SelectorRow<Cell>, ConfigurableRow where Cell: BaseCell, Cell.Value == String {
        fileprivate private(set) var intro: String?
        private let selector: DataListSelectorViewController<SelectorRow<Cell>> = DataListSelectorViewController<SelectorRow<Cell>>()

        public required init(tag: String?) {
            super.init(tag: tag)

            presentationMode = .show(controllerProvider: ControllerProvider.callback { self.selector }, onDismiss: { _ in
                // Nothing to do
            })
        }

        public func intro(_ intro: String) -> Self {
            self.intro = intro
            selector.updateContent()
            return self
        }
    }

    public final class DataListRow: _DataListRow<PushSelectorCell<String>>, RowType {
//    var html: String?

        public required init(tag: String?) {
            super.init(tag: tag)
        }
    }

    private class DataListSelectorViewController<OptionsRow: OptionsProviderRow>: SelectorViewController<OptionsRow> where OptionsRow.OptionsProviderType.Option == String {
        private var configurableRow: ConfigurableRow? { return row as? ConfigurableRow }

        public override func viewDidLoad() {
            super.viewDidLoad()

            updateContent()
            appendTextRow()
        }

        fileprivate func updateContent() {
            // Can be nil because this method may get called before the view controller is shown.
            if let section = form.allSections.first {
                if let intro = configurableRow?.intro {
                    section.header?.title = intro
                }
                tableView.reloadData()
            }
        }

        private func appendTextRow() {
            let section = form.allSections.first!
            let row = TextRow { row in
                row.title = "Other (Please specify)"
            }.cellSetup { _, row in
                for option in self.optionsProviderRow.optionsProvider?.optionsArray ?? [] where option == self.row.value {
                    return
                }
                // Only initialize the text field when no option is selected
                row.value = self.row.value
            }.cellUpdate { _, row in
                let changed = self.row.value != (row.value ?? "")
                if row.value != nil, changed {
                    self.row.value = row.value
                    self.row.reload() // Reflect the change in UI
                    self.onDismissCallback?(self)
                }
            }

            section <<< row
        }
    }

#endif
