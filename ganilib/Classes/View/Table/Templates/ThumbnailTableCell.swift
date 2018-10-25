open class ThumbnailTableCell: GTableViewCustomCell {
    public let picture = GImageView()
    public let title = GLabel().specs(.libCellTitle)
    public let subtitle = GLabel().specs(.libCellSubtitle)

    open override func initContent() {
        let content = GHorizontalPanel()
            .append(picture.width(80).height(80))
            .append(GVerticalPanel().paddings(t: 10, l: 10, b: 10, r: 10).append(title).append(subtitle))

        paddings(t: 8, l: 14, b: 8, r: 14)
            .append(content)
            .done()
    }
}
