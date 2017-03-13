//
//  Fachada.swift
//  WeatherTalentoMobile
//
//  Created by Esther on 11/3/17.
//  Copyright © 2017 Esther. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import Realm
import RealmSwift
import ObjectMapper

class Fachada: NSObject, XMLParserDelegate{
    
    
    static var instance: Fachada!
    var properties: NSDictionary!
    var urlBase : String!
    
    
    
    
    override init() {
        super.init()
        setBaseUrl()
        
    }
    
    func setBaseUrl() {
        if let path = Bundle.main.path(forResource: "APIProperties", ofType: "plist") {
            properties = NSDictionary(contentsOfFile: path)
            urlBase = properties.object(forKey: "urlBase") as! String
        }
        
    }
    
    
    
    
    class func sharedInstance() -> Fachada {
        self.instance = (self.instance ?? Fachada())
        return self.instance
    }
    
    
    func getGeographicalInfo(text: String, completion: @escaping (_ response: AnyObject?) -> ()) {
        
        let urlInfo = properties.object(forKey: "infoService") as! String
        let user1 = properties.object(forKey: "user1") as! String
        let URL = urlBase + urlInfo + "?q=" + text + "&maxRows=20&startRow=0&lang=en&isNameRequired=true&style=FULL&username=" + user1
        let encodedURL = URL.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result{
                case .success(let value):
                    completion(value as AnyObject?)
                    
                case .failure(let error):
                    completion(error as AnyObject?)
                }
        }
        
        
        
    }
    
    
    func getWeatherInfo(location: Location, completion: @escaping (_ response: AnyObject?) -> ()) {
        
        
        let north = String(format:"%f", (location.cardinals?.north)!)
        let south = String(format:"%f", (location.cardinals?.south)!)
        let east = String(format:"%f", (location.cardinals?.east)!)
        let west = String(format:"%f", (location.cardinals?.west)!)
        
        let urlWeather = properties.object(forKey: "weatherService") as! String
        let user1 = properties.object(forKey: "user1") as! String
        let URL = urlBase + urlWeather + "?north=" + north + "&south=" + south + "&east=" + east + "&west=" + west + "&username=" + user1
        
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result{
                case .success(let value):
                    completion(value as AnyObject?)
                    
                case .failure(let error):
                    completion(error as AnyObject?)
                }
        }
        
        
        
    }
    
    
    
}
