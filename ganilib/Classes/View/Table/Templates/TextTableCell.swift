open class TextTableCell: GTableViewCustomCell {
    public let title = GLabel().specs(.libCellTitle)
    public let subtitle = GLabel().specs(.libCellSubtitle)

    open override func initContent() {
        paddings(top: 8, left: 14, bottom: 8, right: 14)
            .append(title)
            .append(subtitle)
            .done()
    }
}
