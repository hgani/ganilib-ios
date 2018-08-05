// See http://codeforcaffeine.com/programming/swift-3-ordered-dictionary/
public struct OrderedDictionary<K: Hashable, V> {
    public var keys = [K]()
    var dict = [K:V]()
 
    public var count: Int {
        return self.keys.count
    }
    
    public mutating func removeAll() {
        keys.removeAll()
        dict.removeAll()
    }
 
    public subscript(key: K) -> V? {
        get {
            return self.dict[key]
        }
        set(newValue) {
            if newValue == nil {
                self.dict.removeValue(forKey:key)
                self.keys = self.keys.filter {$0 != key}
            } else {
                let oldValue = self.dict.updateValue(newValue!, forKey: key)
                if oldValue == nil {
                    self.keys.append(key)
                }
            }
        }
    }
}
 
extension OrderedDictionary: Sequence {
    public typealias Iterator = AnyIterator<(key: K, value: V)>
    
    public func makeIterator() -> Iterator {
        var counter = 0
        return AnyIterator {
            guard counter<self.keys.count else {
                return nil
            }
            let key = self.keys[counter]
//            let next = self.dict[self.keys[counter]]
            let value = self.dict[key]!
            counter += 1
            return (key, value)
//            return value
        }
        
//        let mapped = self.__source.lazy.map {
//            ($0.key as AnyObject, abcContainer($0.value))
//        }
//        return AnyIterator(mapped.makeIterator())
    }
}
 
extension OrderedDictionary: CustomStringConvertible {
    public var description: String {
        let isString = type(of: self.keys[0]) == String.self
        var result = "["
        for key in keys {
            result += isString ? "\"\(key)\"" : "\(key)"
            result += ": \(self[key]!), "
        }
        result = String(result.dropLast(2))
        result += "]"
        return result
    }
}
 
extension OrderedDictionary: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (K, V)...) {
        self.init()
        for (key, value) in elements {
            self[key] = value
        }
    }
}
