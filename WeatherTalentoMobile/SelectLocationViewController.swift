//
//  SelectLocationViewController.swift
//  WeatherTalentoMobile
//
//  Created by Esther on 12/3/17.
//  Copyright © 2017 Esther. All rights reserved.
//

import UIKit

class SelectLocationViewController: UIViewController, SelectLocationViewModelDelegate {
    
    var viewModel : SelectLocationViewModel!
    
    
    @IBOutlet var locationsTableView: UITableView!
    
    
    
    var listLocations : [Location]!
    var selectedLocation : Location!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SelectLocationViewModel()
        viewModel.delegate = self
        
        setupNavigationBar()
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
        
        var imageBack = UIImage(named: "icon-back-black")
        
        imageBack = imageBack?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let back: UIBarButtonItem = UIBarButtonItem(image: imageBack, style: .plain, target: self, action: #selector(SelectLocationViewController.close(_:)))
        self.navigationItem.leftBarButtonItem = back
        
        self.navigationItem.rightBarButtonItem = nil
        
    }
    
    
    
    func dataReceived(){
        stopActivityIndicator()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ShowData") as! ShowDataViewController
        controller.temperature = viewModel.temperature
        controller.location = selectedLocation
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func close(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SelectLocationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        startActivityIndicator()
        
        selectedLocation = listLocations[indexPath.row]
        viewModel.getWeatherData(location: selectedLocation)
        
    }
    
}

extension SelectLocationViewController: UITableViewDataSource {
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }
    @objc(tableView:estimatedHeightForRowAtIndexPath:) func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func numberOfSectionsIntableView(_tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listLocations.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let location = listLocations[indexPath.row]
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath as IndexPath) as! LocationTableViewCell
        cell.nameLocation.text = location.name + ", " + location.countryName
        
        
        return cell
        
    }
}
