public class ThumbnailTableCell: GTableViewCustomCell {
    public let picture = GImageView()
    public let title = GLabel().specs(.libCellTitle)
    public let subtitle = GLabel().specs(.libCellSubtitle)
    
    override public func initContent() {
        let content = GHorizontalPanel()
            .append(picture.width(80).height(80))
            .append(GVerticalPanel().paddings(t: 5, l: 10, b: 5, r: 10).append(title).append(subtitle))
        
        self
            .paddings(t: 8, l: 14, b: 8, r: 14)
            .append(content)
            .done()
    }
}

