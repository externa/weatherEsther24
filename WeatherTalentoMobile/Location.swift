//
//  Location.swift
//  WeatherTalentoMobile
//
//  Created by Esther on 12/3/17.
//  Copyright © 2017 Esther. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import ObjectMapper

class Location: Object, Mappable {
    
    dynamic var name = ""
    dynamic var cardinals : Cardinals? = nil
    dynamic var fcl = ""
    dynamic var countryCode = ""
    dynamic var countryName = ""
    dynamic var lat = ""
    dynamic var lng = ""
    dynamic var compoundKey: String = ""
    
    
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        //fatalError("init(realm:schema:) has not been implemented")
        super.init(realm: realm, schema: schema)
        
    }
    
    
    func setCompoundName(name: String) {
        self.name = name
        compoundKey = compoundKeyValue()
    }
    
    func setCompoundCountry(countryName: String) {
        self.countryName = countryName
        compoundKey = compoundKeyValue()
    }
    
    
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    func compoundKeyValue() -> String {
        return "\(name)\(countryName)"
    }
    
    func mapping(map: Map) {
        
        name <- map["asciiName"]
        cardinals <- map["bbox"]
        fcl <- map["fcl"]
        countryCode <- map["countryCode"]
        countryName <- map["countryName"]
        lat <- map["lat"]
        lng <- map["lng"]
    }
    
    required init?(map: Map){
        super.init()
        self.mapping(map: map)
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
}

class Cardinals: Object, Mappable {
    
    dynamic var east = 0.0
    dynamic var south = 0.0
    dynamic var north = 0.0
    dynamic var west = 0.0
    
    
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        //fatalError("init(realm:schema:) has not been implemented")
        super.init(realm: realm, schema: schema)
        
    }
    
    
    //    override class func primaryKey() -> String? {
    //
    //    }
    
    func mapping(map: Map) {
        
        east <- map["east"]
        south <- map["south"]
        north <- map["north"]
        west <- map["west"]
        
    }
    
    required init?(map: Map){
        super.init()
        self.mapping(map: map)
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
}

