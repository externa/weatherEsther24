//
//  UIViewController+GenericError.swift
//  WeatherTalentoMobile
//
//  Created by Esther on 13/3/17.
//  Copyright © 2017 Esther. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func createWhiteOverlayView() -> UIView {
        let viewToReturn = UIView()
        
        viewToReturn.backgroundColor = UIColor(red: 127.0/255.0, green: 158.0/255.0, blue: 208.0/255.0, alpha: 0.8)
        viewToReturn.tag = 500
        viewToReturn.translatesAutoresizingMaskIntoConstraints = false
        
        return viewToReturn
    }
    
    func createMessageOverlayView() -> UIView {
        let messageOverlayView = UIView()
        messageOverlayView.translatesAutoresizingMaskIntoConstraints = false
        
        messageOverlayView.backgroundColor = UIColor.init(red: 229.0/255.0, green: 0.0, blue: 125.0/255.0, alpha: 1.0)
        messageOverlayView.layer.cornerRadius = 10
        
        return messageOverlayView
    }
    
    func createErrorLabelView() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont(name: "Roboto-Light", size: 20)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        return label
    }
    
    
    
    func showGenericError(message: String) {
        guard !message.isEmpty else {
            return
        }
        let myView = self.navigationController?.view!
        
        // Creating and setting up the white background
        let whiteOverlayView = createWhiteOverlayView()
        
        // Creating and setting up the error message box
        let messageOverlayView = createMessageOverlayView()
        
        // Creating and setting up the error message
        let messageOverlayViewLabel = createErrorLabelView()
        messageOverlayViewLabel.text = message
        
        
        // Adding these views to superview
        messageOverlayView.addSubview(messageOverlayViewLabel)
        whiteOverlayView.addSubview(messageOverlayView)
        myView!.addSubview(whiteOverlayView)
        
        // Setting up constraints for white background
        let whiteOverlayViewLeftConstraint = NSLayoutConstraint(
            item: whiteOverlayView,
            attribute: NSLayoutAttribute.left,
            relatedBy: NSLayoutRelation.equal,
            toItem: myView,
            attribute: NSLayoutAttribute.left,
            multiplier: 1,
            constant: 0
        )
        let whiteOverlayViewRightConstraint = NSLayoutConstraint(
            item: whiteOverlayView,
            attribute: NSLayoutAttribute.right,
            relatedBy: NSLayoutRelation.equal,
            toItem: myView,
            attribute: NSLayoutAttribute.right,
            multiplier: 1,
            constant: 0
        )
        let whiteOverlayViewTopConstraint = NSLayoutConstraint(
            item: whiteOverlayView,
            attribute: NSLayoutAttribute.top,
            relatedBy: NSLayoutRelation.equal,
            toItem: myView,
            attribute: NSLayoutAttribute.top,
            multiplier: 1,
            constant: 0
        )
        let whiteOverlayViewBottomConstraint = NSLayoutConstraint(
            item: whiteOverlayView,
            attribute: NSLayoutAttribute.bottom,
            relatedBy: NSLayoutRelation.equal,
            toItem: myView,
            attribute: NSLayoutAttribute.bottom,
            multiplier: 1,
            constant: 0
        )
        let whiteOverlayConstraints = [whiteOverlayViewLeftConstraint,whiteOverlayViewRightConstraint,whiteOverlayViewTopConstraint,whiteOverlayViewBottomConstraint]
        myView!.addConstraints(whiteOverlayConstraints)
        NSLayoutConstraint.activate(whiteOverlayConstraints)
        
        // Setting up constraints for error message box
        let messageOverlayViewLeftConstraint = NSLayoutConstraint(
            item: messageOverlayView,
            attribute: NSLayoutAttribute.left,
            relatedBy: NSLayoutRelation.equal,
            toItem: whiteOverlayView,
            attribute: NSLayoutAttribute.left,
            multiplier: 1,
            constant: 20
        )
        let messageOverlayViewRightConstraint = NSLayoutConstraint(
            item: messageOverlayView,
            attribute: NSLayoutAttribute.right,
            relatedBy: NSLayoutRelation.equal,
            toItem: whiteOverlayView,
            attribute: NSLayoutAttribute.right,
            multiplier: 1,
            constant: -20
        )
        let messageOverlayViewCenterXConstraint = NSLayoutConstraint(
            item: messageOverlayView,
            attribute: NSLayoutAttribute.centerX,
            relatedBy: NSLayoutRelation.equal,
            toItem: whiteOverlayView,
            attribute: NSLayoutAttribute.centerX,
            multiplier: 1,
            constant: 0
        )
        let messageOverlayViewCenterYConstraint = NSLayoutConstraint(
            item: messageOverlayView,
            attribute: NSLayoutAttribute.centerY,
            relatedBy: NSLayoutRelation.equal,
            toItem: whiteOverlayView,
            attribute: NSLayoutAttribute.centerY,
            multiplier: 1,
            constant: 0
        )
        let messageOverlayViewConstraints = [messageOverlayViewLeftConstraint, messageOverlayViewRightConstraint, messageOverlayViewCenterXConstraint, messageOverlayViewCenterYConstraint]
        whiteOverlayView.addConstraints(messageOverlayViewConstraints)
        NSLayoutConstraint.activate(messageOverlayViewConstraints)
        // sizeToFit of the label, here we calculate the height of the (potentially) multilined error label
        messageOverlayViewLabel.sizeToFit()
        
        
        
        // Setting up constraints for the error label
        let messageOverlayViewTextViewTopConstraint = NSLayoutConstraint(
            item: messageOverlayViewLabel,
            attribute: NSLayoutAttribute.top,
            relatedBy: NSLayoutRelation.equal,
            toItem: messageOverlayView,
            attribute: NSLayoutAttribute.top,
            multiplier: 1,
            constant: 10
        )
        let messageOverlayViewTextViewBottomConstraint = NSLayoutConstraint(
            item: messageOverlayViewLabel,
            attribute: NSLayoutAttribute.bottom,
            relatedBy: NSLayoutRelation.equal,
            toItem: messageOverlayView,
            attribute: NSLayoutAttribute.bottom,
            multiplier: 1,
            constant: -10
        )
        let messageOverlayViewTextViewLeftConstraint = NSLayoutConstraint(
            item: messageOverlayViewLabel,
            attribute: NSLayoutAttribute.left,
            relatedBy: NSLayoutRelation.equal,
            toItem: messageOverlayView,
            attribute: NSLayoutAttribute.left,
            multiplier: 1,
            constant: 30
        )
        let messageOverlayViewTextViewRightConstraint = NSLayoutConstraint(
            item: messageOverlayViewLabel,
            attribute: NSLayoutAttribute.right,
            relatedBy: NSLayoutRelation.equal,
            toItem: messageOverlayView,
            attribute: NSLayoutAttribute.right,
            multiplier: 1,
            constant: -30
        )
        
        let messageOverlayViewTextViewConstraints = [messageOverlayViewTextViewTopConstraint, messageOverlayViewTextViewBottomConstraint, messageOverlayViewTextViewLeftConstraint, messageOverlayViewTextViewRightConstraint]
        messageOverlayView.addConstraints(messageOverlayViewTextViewConstraints)
        NSLayoutConstraint.activate(messageOverlayViewTextViewConstraints)
        
        // Redistribute elements using the constraints
        view.setNeedsLayout()
        
        // Gesture recognizer: hide error on tap
        let removeSelector : Selector = #selector(UIViewController.hideGenericError)
        let tapGesture = UITapGestureRecognizer(target: self, action: removeSelector)
        whiteOverlayView.addGestureRecognizer(tapGesture)
        
    }
    
    func hideGenericError() {
        if let viewWithTag = self.navigationController?.view!.viewWithTag(500){
            viewWithTag.removeFromSuperview()
        }
    }
}

