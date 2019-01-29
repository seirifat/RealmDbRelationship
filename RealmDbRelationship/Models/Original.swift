//
//  Original.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on January 25, 2019

import Foundation
import SwiftyJSON
import RealmSwift

class Original: Object {

    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var manufacturer: String?

//    var products: List<Product> = List<Product>()
    
    let products = LinkingObjects(fromType: Product.self, property: "originalsList")
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
	public static func with(realm: Realm, json: JSON) -> Original? {
        let identifier = json["id"].stringValue
        if identifier == "" {
            return nil
        }
        var obj = realm.object(ofType: Original.self, forPrimaryKey: identifier)
        if obj == nil {
            obj = Original()
            obj?.id = identifier
        } else {
            obj = Original(value: obj!)
        }
        
        if json["id"].exists() {
            obj?.id = json["id"].string
        }
        
        if json["name"].exists() {
            obj?.name = json["name"].string
        }
        
        if json["manufacturer"].exists() {
            obj?.manufacturer = json["manufacturer"].string
        }
        
//        if json["products"].exists() {
//            obj?.products.removeAll()
//            for itemJson in json["products"].arrayValue {
//                if let item = Product.with(json: itemJson) {
//                    obj?.products.append(item)
//                }
//            }
//        }
        
        return obj
	}

    public static func with(json: JSON) -> Original? {
        return with(realm: try! Realm(), json: json)
    }
    
}
