open class ThumbnailTableCell: GTableViewCustomCell {
    public let picture = GImageView()
    public let title = GLabel().specs(.libCellTitle)
    public let subtitle = GLabel().specs(.libCellSubtitle)

    open override func initContent() {
        let content = GHorizontalPanel()
            .append(picture.width(80).height(80))
            .append(GVerticalPanel().paddings(top: 10, left: 10, bottom: 10, right: 10).append(title).append(subtitle))

        paddings(top: 8, left: 14, bottom: 8, right: 14)
            .append(content)
            .done()
    }
}
