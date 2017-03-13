//
//  ViewController.swift
//  WeatherTalentoMobile
//
//  Created by Esther on 11/3/17.
//  Copyright © 2017 Esther. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, SearchViewModelDelegate {
    
    var viewModel : SearchViewModel!
    
    @IBOutlet var helloLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    
    @IBOutlet var buttonBottomDistanceConstraint: NSLayoutConstraint!
    @IBOutlet var textTopDistanceConstraint: NSLayoutConstraint!
    
    var initialBottomDistance : CGFloat = 100.0
    var initialTopDistance : CGFloat = 286.0
    
    var keyboardUp = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewModel = SearchViewModel()
        
        viewModel.delegate = self
        setupNavigationBar()
        setUpView()
        
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(SearchViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SearchViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
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
        
        self.navigationItem.leftBarButtonItem = nil
        
        self.navigationItem.rightBarButtonItem = nil
        
    }
    
    
    func setUpView() {
        helloLabel.font = Fonts.Title
        textLabel.font = Fonts.Text
        searchButton.layer.cornerRadius = 20
        searchButton.titleLabel?.font = Fonts.Button
        textField.autocorrectionType = .no
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if keyboardUp == false {
            let info = notification.userInfo!
            let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            
            self.buttonBottomDistanceConstraint.constant = keyboardFrame.size.height + initialBottomDistance
            self.textTopDistanceConstraint.constant = initialTopDistance - keyboardFrame.size.height
            
            
            UIView.animate(withDuration: 2) {
                self.helloLabel.layer.opacity = 0.0
                self.view.layoutIfNeeded()
            }
            keyboardUp = true
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if keyboardUp == true {
            
            self.buttonBottomDistanceConstraint.constant = initialBottomDistance
            self.textTopDistanceConstraint.constant = initialTopDistance
            
            
            UIView.animate(withDuration: 2) {
                self.helloLabel.layer.opacity = 1.0
                self.view.layoutIfNeeded()
            }
            keyboardUp = false
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func search(_ sender: AnyObject) {
        startActivityIndicator()
        viewModel.getGeographicalData(text: textField.text!)
        
    }
    
    
    
    @IBAction func goToHistory(_ sender: AnyObject) {
        viewModel.getHistory()
    }
    
    
    
    
    func dataReceived(){
        stopActivityIndicator()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SelectLocation") as! SelectLocationViewController
        controller.listLocations = viewModel.listLocations
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func showError(msg:String){
        stopActivityIndicator()
        showGenericError(message: msg)
        
    }
    
    
}

