//
//  UIViewController+ActivityIndicator.swift
//  WeatherTalentoMobile
//
//  Created by Esther on 12/3/17.
//  Copyright © 2017 Esther. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var viewActivityIndicatorTag: Int { return 888888 }
    var sizeActivityIndicator: CGFloat { return 90 }
    
    static func instanceWithDefaultNib() -> Self {
        let className = NSStringFromClass(self as! AnyClass).components(separatedBy: " ").last
        let bundle = Bundle(for: self as! AnyClass)
        return self.init(nibName: className, bundle: bundle)
    }
    
    
    
    func startActivityIndicator() {
        
        
        //Ensure the UI is updated from the main thread
        
        //in case this method is called from a closure
        
        DispatchQueue.main.async(execute: {
            
            //First we create the view
            
            let newView = UIView()
            newView.backgroundColor = UIColor.white
            newView.alpha = 0.8
            
            newView.tag = self.viewActivityIndicatorTag
            
            let gif = UIImage.gifWithName(name: "loading")
            let activityIndicator = UIImageView(image: gif)
            activityIndicator.frame = CGRect(x: self.view.frame.size.width / 2 - self.sizeActivityIndicator / 2, y:
                self.view.frame.size.height / 2 - self.sizeActivityIndicator / 2, width: self.sizeActivityIndicator, height: self.sizeActivityIndicator)
            
            newView.addSubview(activityIndicator)
            
            newView.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height + 64)
            
            self.view.addSubview(newView)
            
            newView.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    
    func stopActivityIndicator() {
        
        //Again, we need to ensure the UI is updated from the main thread!
        
        DispatchQueue.main.async(execute: {
            //Here we find the `UIActivityIndicatorView` and remove it from the view
            
            
            if (self.navigationController != nil) {
                if let viewActivityIndicator = self.view.subviews.filter(
                    { $0.tag == self.viewActivityIndicatorTag}).first as UIView! {
                    viewActivityIndicator.removeFromSuperview()
                }
            }
        })
    }
}
