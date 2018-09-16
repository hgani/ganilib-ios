import GaniLib

class JsonTemplate_FeaturedV1: JsonTemplate {
    override func createCell() -> GTableViewCell {
        let cell = tableView.cellInstance(of: FeaturedTableCell.self, style: .default)
        
        _ = cell.picture.source(url: spec["imageUrl"].stringValue)
        cell.title.text = spec["title"].stringValue
        cell.subtitle.text = spec["subtitle"].stringValue
        
        return cell
    }
}
