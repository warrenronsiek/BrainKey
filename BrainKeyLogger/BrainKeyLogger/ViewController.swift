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
//            self.keyMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.keyDown]) { (event) in
//                self.logs.textStorage?.append(NSAttributedString(string: "logged: \(event.characters ?? "unknown") at time \(event.timestamp)) with keycode \(event.keyCode)\n"))
//                print(event)
//            }
            
            self.flagMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.flagsChanged]) { (event) in
                self.logs.textStorage?.append(NSAttributedString(string: "logged flagchange to \(event.modifierFlags.rawValue) at time \(event.timestamp)) with keycode \(event.keyCode)\n"))
                print(event)
            }
            self.isLogging = true
        } else {
            NSEvent.removeMonitor(keyMonitor as Any)
            NSEvent.removeMonitor(flagMonitor as Any)
            self.isLogging = false
        }

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

