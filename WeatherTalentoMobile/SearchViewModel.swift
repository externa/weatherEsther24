//
//  ViewModel.swift
//  WeatherTalentoMobile
//
//  Created by Esther on 11/3/17.
//  Copyright © 2017 Esther. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

protocol SearchViewModelDelegate {
    func dataReceived()
    func showError(msg:String)
}


class SearchViewModel: NSObject {
    
    var delegate: SearchViewModelDelegate?
    var userCases: UserCases!
    var listLocations : [Location]!
    
    override init() {
        super.init()
        userCases = UserCases()
    }
    
    func getGeographicalData(text: String){
        
        
        userCases.getGeographicalInfo(text: text, completion: { (response) in
            self.checkGeographicalData(data: response)
        })
        
        
    }
    
    
    func checkGeographicalData(data: () throws ->[Location]?){
        do{
            let result = try data()
            if ( result != nil) {
                listLocations = result
                if listLocations != nil && listLocations.count > 0 {
                    self.delegate?.dataReceived()
                } else {
                    let msg = "No hay localizaciones disponibles"
                    self.delegate?.showError(msg: msg)
                }
                
            }
            else{
                self.delegate?.showError(msg: "Ha ocurrido un error al recuperar los datos")
            }
        }catch let error{
            self.delegate?.showError(msg: error.localizedDescription)
        }
    }
    
    func getHistory(){
        let realm = try! Realm()
        listLocations = Array(realm.objects(Location.self))
        if listLocations != nil && listLocations.count > 0 {
            self.delegate?.dataReceived()
        } else {
            let msg = "No hay localizaciones en el historial"
            self.delegate?.showError(msg: msg)
        }
        
    }
    
    
}
