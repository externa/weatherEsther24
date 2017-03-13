//
//  UserCases.swift
//  WeatherTalentoMobile
//
//  Created by Esther on 11/3/17.
//  Copyright © 2017 Esther. All rights reserved.
//

import Foundation
import ObjectMapper
import Realm
import RealmSwift


enum errors: Error {
    case InternalError
    case ServerError(code: String)
    // Aqui podemos insertar más tipos de error
}
func == (err1: errors, err2: errors) -> Bool {
    switch (err1, err2) {
    case (.InternalError, .InternalError): return true
    case let (.ServerError(code1), .ServerError(code2))
        where code1 == code2 : return true
    default: return false
    }
}

class UserCases: NSObject {
    
    
    
    func getGeographicalInfo(text: String, completion: @escaping (_ response: () throws ->  [Location]?) -> Void){
        
        
        Fachada.sharedInstance().getGeographicalInfo(text: text, completion: { (response) in
            
            // Error incontrolable
            if (response as? Error) != nil{
                completion({throw errors.InternalError})
                return
            }
            
            // Error de datos del servidor
            guard let result = response as? [String: AnyObject]
                else{
                    completion({throw errors.InternalError})
                    return
            }
            
            // Error controlado por el servidor
            if let error = result["error"] as? [String: AnyObject]{
                if let code = error["code"] as? String{
                    completion({throw errors.ServerError(code: code)})
                }
                else{
                    completion({throw errors.InternalError})
                }
                return
            }
            
            
            let res = result["geonames"] as? [[String:AnyObject]]
            if (res != nil){
                var arrayLocations = [Location]()
                for loc in res!{
                    //Filtro los que no tienen las coordenadas para la busqueda de los datos de la temperatura y las poblaciones
                    if loc["bbox"] != nil && loc["fcl"] as! String == "P" {
                        let map = Map.init(mappingType: MappingType.fromJSON, JSON: loc)
                        let locMap = Location(map: map)
                        locMap?.setCompoundName(name: (locMap?.name)!)
                        locMap?.setCompoundCountry(countryName: (locMap?.countryName)!)
                        arrayLocations.append(locMap!)
                    }
                }
                completion({return arrayLocations})
            }
            else {
                completion({throw errors.InternalError})
            }
        })
        
        
        
    }
    
    
    func getWeatherInfo(location: Location, completion: @escaping (_ response: () throws ->  [Weather]?) -> Void){
        
        
        Fachada.sharedInstance().getWeatherInfo(location: location, completion: { (response) in
            
            // Error incontrolable
            if (response as? Error) != nil{
                completion({throw errors.InternalError})
                return
            }
            
            // Error de datos del servidor
            guard let result = response as? [String: AnyObject]
                else{
                    completion({throw errors.InternalError})
                    return
            }
            
            // Error controlado por el servidor
            if let error = result["error"] as? [String: AnyObject]{
                if let code = error["code"] as? String{
                    completion({throw errors.ServerError(code: code)})
                }
                else{
                    completion({throw errors.InternalError})
                }
                return
            }
            
            let res = result["weatherObservations"] as? [[String:AnyObject]]
            if (res != nil){
                var arrayTemperatures = [Weather]()
                for temp in res!{
                    
                    let map = Map.init(mappingType: MappingType.fromJSON, JSON: temp)
                    let tempMap = Weather(map: map)
                    
                    arrayTemperatures.append(tempMap!)
                }
                completion({return arrayTemperatures})
            }
            else {
                completion({throw errors.InternalError})
            }
        })
        
        
        
    }
}
