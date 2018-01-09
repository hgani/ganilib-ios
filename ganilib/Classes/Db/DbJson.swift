#if INCLUDE_REALM

import RealmSwift

public class DbJson: Object {
    static let realm = try! Realm()
    
    @objc dynamic var key = ""
    @objc dynamic var value = ""
    
    private static func row(key: String) -> DbJson? {
        return realm.objects(DbJson.self).filter("key = %@", key).first
    }
    
    // TODO: Make it thread safe
    public static func set(_ key: String, _ obj: Json) {
        if let str = obj.rawString() {
            try! realm.write {
                if let row = row(key: key) {
                    row.value = str
                }
                else {
                    let row = DbJson()
                    row.key = key
                    row.value = str
                    realm.add(row)
                }
            }
        }
    }
    
    public static func get(_ key: String) -> Json {
        if let row = row(key: key) {
            let json = Json(parseJSON: row.value)
            
            do {
                _ = try json.rawData()
                return json
            } catch {  // E.g. a JSON that is just a standalone string value
                return Json(row.value)
            }
        }
        return Json(NSNull())
    }
    
    // TODO: Make it thread safe
    public static func delete(_ key: String) {
        if let row = row(key: key) {
            try! realm.write {
                realm.delete(row)
            }
        }
    }
}

#endif
