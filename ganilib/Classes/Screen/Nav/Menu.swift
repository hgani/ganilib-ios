
public class Menu {
    private var items = [MenuItem]()

    var count: Int {
        return items.count
    }

    subscript(index: Int) -> MenuItem {
        return items[index]
    }

    public func add(_ item: MenuItem) {
        items.append(item)
    }

    public func clear() {
        items.removeAll()
    }
}
