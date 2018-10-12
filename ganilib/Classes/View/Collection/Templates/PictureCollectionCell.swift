public class PictureCollectionCell: GCollectionViewCell {
    public let picture = GImageView()
    
    override public func initContent() {
        self
            .append(picture)
            .done()
    }
}
