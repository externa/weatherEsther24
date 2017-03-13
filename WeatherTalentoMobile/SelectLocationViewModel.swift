//
//  SelectLocationViewModel.swift
//  WeatherTalentoMobile
//
//  Created by Esther on 12/3/17.
//  Copyright © 2017 Esther. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

protocol SelectLocationViewModelDelegate {
    func dataReceived()
}


class SelectLocationViewModel: NSObject {
    
    var delegate: SelectLocationViewModelDelegate?
    var userCases: UserCases!
    var listTemperatures : [Weather]!
    var temperature : Double!
    
    override init() {
        super.init()
        userCases = UserCases()
    }
    
    
    
    func getWeatherData(location: Location){
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(location, update: true)
        }
        userCases.getWeatherInfo(location:location, completion: { (response) in
            self.checkWeatherData(data: response)
        })
    }
    
    func checkWeatherData(data: () throws ->[Weather]?){
        do{
            let result = try data()
            if ( result != nil) {
                
                listTemperatures = result
                self.prepareData()
                
                
            }
            else{
                //self.errorManagerProtocolDelegate.sendMsgGenericErrorDelegate("El producto ya esta asociado o se ha producido un error")
            }
        }catch let error{
            //self.errorManagerProtocolDelegate.sendMsgGenericErrorTypeDelegate(error as! errors)
        }
    }
    
    
    func prepareData(){
        if listTemperatures.count > 0 {
            var mediumTemp = 0.0
            for temp in listTemperatures {
                let tempDouble = Double(temp.temperature)
                mediumTemp = mediumTemp + tempDouble!
            }
            temperature = mediumTemp / Double(listTemperatures.count)
            
        } else {
            temperature = nil
        }
        self.delegate?.dataReceived()
        
    }
    
    
}

