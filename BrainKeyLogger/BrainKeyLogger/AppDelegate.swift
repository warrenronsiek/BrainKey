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
    var keyMonitor: Any?
    var flagMonitor: Any?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String : true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options)
        
        if !accessEnabled {
            print("Access Not Enabled")
        }
        
        keyMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.keyDown]) { (event) in
            print(event)
        }
        
        flagMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.flagsChanged]) { (event) in
            print(event)
        }
    }


    func applicationWillTerminate(_ aNotification: Notification) {
        NSEvent.removeMonitor(keyMonitor as Any)
        NSEvent.removeMonitor(flagMonitor as Any)
    }


}

