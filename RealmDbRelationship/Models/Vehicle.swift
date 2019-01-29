//
//  Vehicle.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on January 25, 2019

import Foundation
import SwiftyJSON
import RealmSwift

class Vehicle: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var segment: String?
    @objc dynamic var engineSeries: String?
    @objc dynamic var name: String?
    @objc dynamic var manufacturer: String?
    
//    var products: List<Product> = List<Product>()
    
    let products = LinkingObjects(fromType: Product.self, property: "vehiclesList")

    override public static func primaryKey() -> String? {
        return "id"
    }
    
	public static func with(realm: Realm, json: JSON) -> Vehicle? {
		let identifier = json["id"].intValue
        if identifier == 0 {
            return nil
        }
        var obj = realm.object(ofType: Vehicle.self, forPrimaryKey: identifier)
        if obj == nil {
            obj = Vehicle()
            obj?.id = identifier
        } else {
            obj = Vehicle(value: obj!)
        }
        
        if json["segment"].exists() {
            obj?.segment = json["segment"].string
        }
        
        if json["engine_series"].exists() {
            obj?.engineSeries = json["engine_series"].string
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

    public static func with(json: JSON) -> Vehicle? {
        return with(realm: try! Realm(), json: json)
    }
    
}
