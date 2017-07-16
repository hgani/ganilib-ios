
public class Menu {
    private var items = [MenuItem]()
    
    var count: Int {
        get {
            return items.count
        }
    }
    
    subscript(index: Int) -> MenuItem {
        get {
            return items[index]
        }
    }
    
    public func add(_ item : MenuItem) {
        items.append(item)
    }
}
