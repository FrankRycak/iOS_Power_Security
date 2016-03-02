//
//  ViewController.swift
//  test
//
//  Created by Frank Rycak Jr on 1/6/16.
//  Copyright © 2016 Frank Rycak Jr. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

 //UI Label Outlets
@IBOutlet weak var BatteryLevelLabel: UILabel!
@IBOutlet weak var BatteryStateLabel: UILabel!
    
//Set up AudioPlayer
var audioPlayer = AVAudioPlayer()
    
//Check Battery State
var batteryState: String {
    if UIDevice.currentDevice().batteryState == UIDeviceBatteryState.Unplugged {
        return "Unplugged"
        }
    if UIDevice.currentDevice().batteryState == UIDeviceBatteryState.Charging {
        return "Charging"
        }
    if UIDevice.currentDevice().batteryState == UIDeviceBatteryState.Full {
        return "Full"
        }
        return "Unknown"
    }
    
var batteryCharging: Bool {
        return UIDevice.currentDevice().batteryState == UIDeviceBatteryState.Charging
    }
    
var batteryFull: Bool {
        return UIDevice.currentDevice().batteryState == UIDeviceBatteryState.Full
    }
    
var unPlugged: Bool {
        return UIDevice.currentDevice().batteryState == UIDeviceBatteryState.Unplugged
        
    }
    
//Iintiate alert sound
var alertSound: AVAudioPlayer?

    
    
// function to return the devices battery level
func batteryLevel()-> Float {
    return UIDevice.currentDevice().batteryLevel
    }
 
    
 // VIEW DID LOAD****************
    
override func viewDidLoad() {
    super.viewDidLoad()
        
_ = batteryLevel()
        
//button
let button   = UIButton(type: UIButtonType.System) as UIButton
    button.frame = CGRectMake(100, 200, 100, 100)
    button.backgroundColor = UIColor.redColor()
    button.setTitle("Stop Alarm", forState: UIControlState.Normal)
    button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
    self.view.addSubview(button)

        
        
let alertSound = self.setupAudioPlayerWithFile("siren", type:"mp3") 
    self.alertSound = alertSound
        
        
        
// enables the tracking of the devices battery level
UIDevice.currentDevice().batteryMonitoringEnabled = true
        
        // shows the battery level on labels
BatteryLevelLabel.text = "\(batteryLevel() * 100)%"
BatteryStateLabel.text = "\(batteryState)"
print("Device Battery Level is: \(batteryLevel()) and the state is \(batteryState)")
        
    
        
// doing stuff here
NSNotificationCenter.defaultCenter().addObserver(self, selector: "batteryStateDidChange:", name: UIDeviceBatteryStateDidChangeNotification, object: nil)
    
    
NSNotificationCenter.defaultCenter().addObserver(self, selector: "batteryLevelDidChange:", name: UIDeviceBatteryLevelDidChangeNotification, object: nil)

    }
    
//button pressed action
    
func buttonAction(sender:UIButton!){
        alertSound?.stop()
    }
    
func batteryStateDidChange(notification: NSNotification){
// The stage did change: plugged, unplugged, full charge...
    switch UIDevice.currentDevice().batteryState{
    case .Unplugged:
        alertSound?.play();
    case .Unknown:
        alertSound?.stop()
    case .Charging:
        alertSound?.stop()
    case .Full:
        alertSound?.stop()
            }
    
BatteryStateLabel.text = "\(batteryState)"
        }
    
    
    
    
func batteryLevelDidChange(notification: NSNotification){
        // The battery's level did change (98%, 99%, ...)
    BatteryLevelLabel.text = "\(batteryLevel() * 100)%"
    }

    
//audio
func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        //1
    let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
    let url = NSURL.fileURLWithPath(path!)
        
    //2
    var audioPlayer:AVAudioPlayer?
        
    // 3
    
    do {try audioPlayer = AVAudioPlayer(contentsOfURL: url)
    } catch {
        print("Player not available")
    }
        
    return audioPlayer
}
    
}