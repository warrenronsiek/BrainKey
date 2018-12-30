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
    @IBOutlet weak var label: NSString!
    @IBAction func toggleLogging(sender: AnyObject) {
        
        if !self.isLogging {
            self.keyMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.keyDown]) { (event) in
                print(event)
            }
            
            self.flagMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.flagsChanged]) { (event) in
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

