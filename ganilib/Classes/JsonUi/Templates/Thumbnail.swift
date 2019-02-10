class JsonTemplate_ThumbnailV1: JsonTemplate {
    override func createCell() -> GTableViewCell {
        let cell = tableView.cellInstance(of: ThumbnailTableCell.self, style: .default)

        cell.setImage(url: spec["imageUrl"].string)
        cell.title.text = spec["title"].stringValue
        cell.subtitle.text = spec["subtitle"].stringValue

        return cell
    }
}
