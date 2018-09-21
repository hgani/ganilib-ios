class JsonTemplate_TextV1: JsonTemplate {
    override func createCell() -> GTableViewCell {
        let cell = tableView.cellInstance(of: TextTableCell.self, style: .default)
        
        cell.title.text = spec["title"].stringValue
        cell.subtitle.text = spec["subtitle"].stringValue
        
        return cell
    }
}
