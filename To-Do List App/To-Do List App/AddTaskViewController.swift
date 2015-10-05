//
//  AddTaskViewController.swift
//  To-Do List App
//
//  Created by Rishi Kapadia on 10/4/15.
//  Copyright © 2015 Rishi Kapadia. All rights reserved.
//

import UIKit

protocol AddTaskViewControllerDelegate {
    func controller(controller: AddTaskViewController, didAddItem: String)
}

class AddTaskViewController: UIViewController {
    
    @IBOutlet
    var textField: UITextField!
    
    var delegate: AddTaskViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addTask(sender: AnyObject) {
        if let delegate = self.delegate {
            delegate.controller(self, didAddItem: textField.text!)
        }
    }
    
    @IBAction
    func cancel() {
        dismissViewControllerAnimated(true, completion:nil)
    }

}
