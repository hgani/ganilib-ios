import RealmSwift

public class DbJson: Object {
    static let realm = try! Realm()
    
    dynamic var key = ""
    dynamic var value = ""
    
    private static func row(key: String) -> DbJson? {
        return realm.objects(DbJson.self).filter("key = %@", key).first
    }
    
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
            //            Log.t("OBJ1: \(row) -- \(row.value)")
            let json = Json(parseJSON: row.value)
            //            Log.t("OBJ2: \(json) -- \(type(of: json))")
            
            do {
                _ = try json.rawData()
                return json
            } catch {  // E.g. a JSON that is just a standalone string value
                return Json(row.value)
            }
        }
        return Json(NSNull())
    }
}
