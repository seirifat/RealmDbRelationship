//
//  Product.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on January 25, 2019

import Foundation
import SwiftyJSON
import RealmSwift

class Product: Object {

    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var type: String?
    var vehiclesList: List<Vehicle> = List<Vehicle>()
    var originalsList: List<Original> = List<Original>()

    override public static func primaryKey() -> String? {
        return "id"
    }
    
	public static func with(realm: Realm, json: JSON) -> Product? {
        let identifier = json["id"].stringValue
        if identifier == "" {
            return nil
        }
        var obj = realm.object(ofType: Product.self, forPrimaryKey: identifier)
        if obj == nil {
            obj = Product()
            obj?.id = identifier
        } else {
            obj = Product(value: obj!)
        }
        
        if json["name"].exists() {
            obj?.name = json["name"].string
        }
        
        if json["type"].exists() {
            obj?.type = json["type"].string
        }
        
        if json["vehicles"].exists() {
            obj?.vehiclesList.removeAll()
            for itemJson in json["vehicles"].arrayValue {
                if let item = Vehicle.with(json: itemJson) {
                    obj?.vehiclesList.append(item)
                }
            }
        }
        
        if json["originals"].exists() {
            obj?.originalsList.removeAll()
            for itemJson in json["originals"].arrayValue {
                if let item = Original.with(json: itemJson) {
                    obj?.originalsList.append(item)
                }
            }
        }
        
        return obj
	}

    public static func with(json: JSON) -> Product? {
        return with(realm: try! Realm(), json: json)
    }
    
}
