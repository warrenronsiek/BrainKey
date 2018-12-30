//
//  AppDelegate.swift
//  BrainKeyLogger
//
//  Created by Warren Ronsiek on 12/29/18.
//  Copyright © 2018 Warren Ronsiek. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String : true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options)
        
        if !accessEnabled {
            print("Access Not Enabled")
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {}

}

