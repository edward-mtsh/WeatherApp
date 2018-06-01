//
//  MessageLibrary.swift
//  WeatherApp
//
//  Created by Edward Mtshweni on 2017/11/13.
//  Copyright © 2017 Edward Mtshweni. All rights reserved.
//

import UIKit

enum Error:String {
    case serverError = "Something went wrong, please try again later"
    case locationAccess = "Access to location is required for the application to function, please go to settings and allow the app to access your location"
}

class MessageLibrary {
    static let sharedInstance = MessageLibrary()
    
    func onMainThread(block:@escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }
    
    func presentAlert(controller:BaseViewController, title:String, message:Error) {
        onMainThread {
            let alertController = UIAlertController(title: title, message: message.rawValue, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            controller.present(alertController, animated: true, completion: nil)
        }
    }
}
