public class PictureCollectionCell: GCollectionViewCell {
    public let picture = GImageView()

    public override func initContent() {
        append(picture)
            .done()
    }
}
