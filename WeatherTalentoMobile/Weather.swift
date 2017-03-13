//
//  Weather.swift
//  WeatherTalentoMobile
//
//  Created by Esther on 12/3/17.
//  Copyright © 2017 Esther. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import ObjectMapper

class Weather: Object, Mappable {
    
    dynamic var temperature = ""
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        //fatalError("init(realm:schema:) has not been implemented")
        super.init(realm: realm, schema: schema)
        
    }
    
    
    //    override class func primaryKey() -> String? {
    //
    //    }
    
    func mapping(map: Map) {
        
        temperature <- map["temperature"]
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
