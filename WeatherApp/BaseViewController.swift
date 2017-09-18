//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Edward Mtshweni on 2017/09/17.
//  Copyright © 2017 Edward Mtshweni. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController
    {
    private var _activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad()
        {
        super.viewDidLoad()
        }
    
    func showBusyView()
        {
        UIApplication.shared.beginIgnoringInteractionEvents()
        _activityView.center = self.view.center
        _activityView.color = UIColor.red
        _activityView.startAnimating()
        self.view.addSubview(_activityView)
        self.placeAtCenter(view: _activityView)
        _activityView.center = CGPoint( x: (UIScreen.main.bounds.width / 2), y: (UIScreen.main.bounds.height / 2))
        }
    
    func hideBusyView()
        {
        UIApplication.shared.endIgnoringInteractionEvents()
        _activityView.stopAnimating()
        _activityView.isHidden = true
        _activityView.removeFromSuperview()
        }
    
    func placeAtCenter(view: UIView)
        {
        self.view.addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        }
    
    func showAlert(title:String, message:String)
        {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
        }
    
    func onMainThread(block:@escaping (Void) -> Void)
        {
        DispatchQueue.main.async(execute: block)
        }

    override func didReceiveMemoryWarning()
        {
        super.didReceiveMemoryWarning()
        }
    }
