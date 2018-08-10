public class PictureCollectionCell: GCollectionViewCell {
    public let picture = GImageView()
    
    override public func initContent() {
        self
            .paddings(t: 8, l: 14, b: 8, r: 14)
            .append(picture)
            .done()
    }
}
