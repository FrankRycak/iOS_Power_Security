//
//  batteryState.swift
//  test
//
//  Created by Frank Rycak Jr on 1/20/16.
//  Copyright © 2016 Frank Rycak Jr. All rights reserved.
//

import Foundation
import UIKit


class Battery{
    class func currentDevice() -> UIDevice{
    var batteryMonitoringEnabled = true
    let UIDeviceBatteryStateDidChangeNotification = UIDeviceBatteryState.self
    
    labelTest 
    labelTest2


var batteryState: UIDeviceBatteryState {
    enum UIDeviceBatteryState : Int {
        case Unknown
        
        case Unplugged
        case Charging
        case Full
        }
    }
}

}