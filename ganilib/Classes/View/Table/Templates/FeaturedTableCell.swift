public class FeaturedTableCell: GTableViewCustomCell {
    public let picture = GImageView()
    public let title = GLabel().specs(.libCellTitle)
    public let subtitle = GLabel().specs(.libCellSubtitle)

    public override func initContent() {
        self
            .paddings(t: 8, l: 10, b: 8, r: 10)
            .append(picture.height(200))
            .append(GVerticalPanel().paddings(t: 5, l: 10, b: 5, r: 10).append(title).append(subtitle))
            .done()
    }
}
