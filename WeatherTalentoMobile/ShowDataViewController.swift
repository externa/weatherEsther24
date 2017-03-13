//
//  ShowDataViewController.swift
//  WeatherTalentoMobile
//
//  Created by Esther on 12/3/17.
//  Copyright © 2017 Esther. All rights reserved.
//

import UIKit
import MapKit

class ShowDataViewController: UIViewController {
    
    var temperature : Double!
    var location : Location!
    
    //Tenemos un rango de 60 grados entre -15 y 45. Vamos a calcular la animacion
    //calculando entre este rango de temperaturas
    var totalTemperature = 60.0
    var maxTemperature = 45.0
    var minTemperature = -15.0
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var temperatureMarker: UIView!
    @IBOutlet var temperatureView: UIView!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var bottomConstraintTemperature: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMap()
        setupNavigationBar()
        setUpView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setUpAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setGradienView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.clear
        
        var imageBack = UIImage(named: "icon-back")
        
        imageBack = imageBack?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let back: UIBarButtonItem = UIBarButtonItem(image: imageBack, style: .plain, target: self, action:  #selector(ShowDataViewController.close(_:)))
        self.navigationItem.leftBarButtonItem = back
        
        self.navigationItem.rightBarButtonItem = nil
        
    }
    
    func setUpView(){
        nameLabel.font = Fonts.NameLocation
        nameLabel.text = location.name + ", " + location.countryName
        
        if (temperature) != nil {
            temperatureLabel.font = Fonts.Temperature
            temperatureLabel.text = String(format: "%.1f",(temperature)!) + "ºC"
        } else {
            temperatureLabel.font = Fonts.Text
            temperatureLabel.text = "No hay datos sobre la ubicación especificada"
        }
        
    }
    
    func setUpAnimation(){
        if (temperature) != nil {
            let height = Double(temperatureView.frame.size.height)
            let distance : Double
            
            if temperature < minTemperature {
                distance = 0.0
            } else if temperature > (maxTemperature - Double(temperatureMarker.frame.size.height)) {
                distance = height - Double(temperatureMarker.frame.size.height)
            } else {
                distance  = (height / totalTemperature) * (temperature - minTemperature)
            }
            UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.5,
                           options: [], animations: {
                            self.bottomConstraintTemperature.constant = CGFloat(distance)
                            self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    func setGradienView(){
        
        let gradient : CAGradientLayer = CAGradientLayer()
        gradient.frame = temperatureView.bounds
        gradient.locations = [0.0, 0.2, 0.4, 0.6, 0.8, 1]
        
        let color1 = UIColor.red.cgColor
        let color2 = UIColor.orange.cgColor
        let color3 = UIColor.yellow.cgColor
        let color4 = UIColor.green.cgColor
        let color5 = UIColor.blue.cgColor
        
        
        let arrayColors = [color1, color2, color3, color4, color5]
        
        gradient.colors = arrayColors
        temperatureView.layer.insertSublayer(gradient, at: 0)
    }
    
    
    func setUpMap(){
        
        mapView.mapType = MKMapType.hybrid
        let latitude = Double(location.lat)
        let longitud = Double(location.lng)
        
        let initialLocation = CLLocation(latitude: latitude!, longitude: longitud!)
        let regionRadius: CLLocationDistance = 10000
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius * 2.0, regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(location: initialLocation)
    }
    
    func close(_ sender : UIButton){
        navigationController?.popViewController(animated: true)
    }
    
}
