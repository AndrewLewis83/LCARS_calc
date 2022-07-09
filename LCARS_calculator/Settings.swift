//
//  Settings.swift
//  LCARS_calculator
//
//  Created by Andrew Lewis on 5/26/19.
//  Copyright © 2019 Andrew Lewis. All rights reserved.
//

import Foundation

struct Settings {
    
    static var initialLaunch: Bool {
        get {
            
            let firstLaunch = UserDefaults.standard.bool(forKey: "initialLaunch")
            
            if firstLaunch {
                tipSetting = 20
                UserDefaults.standard.set(false, forKey: "initialLaunch")
            }
            
            return firstLaunch
        }
    }
    
    static var muteSetting: Bool {
        
        get {
            return UserDefaults.standard.bool(forKey: "muteSetting")
        }
        
        set(setting) {
            UserDefaults.standard.set(setting, forKey: "muteSetting")
        }
        
    }
    
    static var tipSetting: Int {
        get {
            return UserDefaults.standard.integer(forKey: "tipSetting")
        }
        
        set(setting) {
            UserDefaults.standard.set(setting, forKey: "tipSetting")
        }
    }
    
}
