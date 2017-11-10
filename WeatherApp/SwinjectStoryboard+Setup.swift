//
//  SwinjectStoryboard+Setup.swift
//  WeatherApp
//
//  Created by Edward Mtshweni on 2017/10/02
//  Copyright © 2017 Edward Mtshweni. All rights reserved.
//

import SwinjectStoryboard

extension SwinjectStoryboard
    {
    class func setup()
        {
        defaultContainer.storyboardInitCompleted(LocationViewController.self)
            { r, c in
            c.server = r.resolve(Server.self)
            }
        defaultContainer.register(Server.self) { _ in Server() }
        }
    }



