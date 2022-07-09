//
//  Settings.swift
//  LCARS_calculator
//
//  Created by Andrew Lewis on 5/26/19.
//  Copyright © 2019 Andrew Lewis. All rights reserved.
//

import Foundation

class Settings {
    
    private static var muted = false
    private static var percentTip: Double = 20
    
    static func getMuteSetting() -> Bool {
        return muted
    }
    
    static func setMuteSetting(newSetting: Bool) {
        muted = newSetting
    }
    
    static func getPercentTip() -> Double {
        return percentTip/100
    }
    
    static func setPercentTip(newTip: Int) {
        percentTip = Double(newTip)
    }
    
}
