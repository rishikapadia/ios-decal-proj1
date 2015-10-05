//
//  DailyStatsViewController.swift
//  To-Do List App
//
//  Created by Rishi Kapadia on 10/4/15.
//  Copyright © 2015 Rishi Kapadia. All rights reserved.
//

import UIKit

class DailyStatsViewController: UIViewController {

    @IBOutlet var counterLabel: UILabel!
    var numberToDisplay = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        counterLabel.text = "\(numberToDisplay)"
    }
}
