open class FeaturedTableCell: GTableViewCustomCell {
    public let picture = GImageView()
    public let title = GLabel().specs(.libCellTitle)
    public let subtitle = GLabel().specs(.libCellSubtitle)

    open override func initContent() {
        self
            .append(picture.height(210))
            .append(GVerticalPanel().paddings(t: 5, l: 10, b: 10, r: 10).append(title).append(subtitle))
            .done()
    }
}
