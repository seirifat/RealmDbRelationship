//
//  DataManager.swift
//  RealmDbRelationship
//
//  Created by Rifat Firdaus on 25/01/19.
//  Copyright © 2019 Rifat Firdaus. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class DataManager: NSObject {

    static let instance = DataManager()
    
    func setupProduct() {
        let realm = try! Realm()
        let partners = realm.objects(Product.self)
        if partners.count == 0 {
            if let path = Bundle.main.path(forResource: "productData", ofType: "json"), let detailData = NSData(contentsOfFile: path) {
                do {
                    let json = try JSON(data: detailData as Data)
                    var data = [Product]()
                    for dataJson in json.arrayValue {
                        if let item = Product.with(json: dataJson) {
                            data.append(item)
                        }
                    }
                    try! realm.write {
                        for item in data {
                            realm.create(Product.self, value: item, update: true)
                        }
                    }
                } catch {
                    
                }
            }
        }
    }
    
    func setupVehicle() {
        let realm = try! Realm()
        let partners = realm.objects(Vehicle.self)
        if partners.count == 0 {
            if let path = Bundle.main.path(forResource: "vehicleData", ofType: "json"), let detailData = NSData(contentsOfFile: path) {
                do {
                    let json = try JSON(data: detailData as Data)
                    var data = [Vehicle]()
                    for dataJson in json.arrayValue {
                        if let item = Vehicle.with(json: dataJson) {
                            data.append(item)
                        }
                    }
                    try! realm.write {
                        for item in data {
                            realm.create(Vehicle.self, value: item, update: true)
                        }
                    }
                } catch {
                    
                }
            }
        }
    }
    
    func setupOriginal() {
        let realm = try! Realm()
        let partners = realm.objects(Original.self)
        if partners.count == 0 {
            if let path = Bundle.main.path(forResource: "originalData", ofType: "json"), let detailData = NSData(contentsOfFile: path) {
                do {
                    let json = try JSON(data: detailData as Data)
                    var data = [Original]()
                    for dataJson in json.arrayValue {
                        if let item = Original.with(json: dataJson) {
                            data.append(item)
                        }
                    }
                    try! realm.write {
                        for item in data {
                            realm.create(Original.self, value: item, update: true)
                        }
                    }
                } catch {
                    
                }
            }
        }
    }
    
}
