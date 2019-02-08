class JsonTemplate_ThumbnailV1: JsonTemplate {
    override func createCell() -> GTableViewCell {
        let cell = tableView.cellInstance(of: ThumbnailTableCell.self, style: .default)

        if let imageUrl = spec["imageUrl"].string {
            cell.picture.source(url: imageUrl)
        } else {
            cell.picture.width(0).height(0)
        }
        cell.title.text = spec["title"].stringValue
        cell.subtitle.text = spec["subtitle"].stringValue

        return cell
    }
}
