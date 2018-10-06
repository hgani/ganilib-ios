open class TextTableCell: GTableViewCustomCell {
    public let title = GLabel().specs(.libCellTitle)
    public let subtitle = GLabel().specs(.libCellSubtitle)
    
    override open func initContent() {
        self
            .paddings(t: 8, l: 14, b: 8, r: 14)
            .append(title)
            .append(subtitle)
            .done()
    }
}
