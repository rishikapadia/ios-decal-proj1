//
//  ViewController.swift
//  To-Do List App
//
//  Created by Rishi Kapadia on 10/4/15.
//  Copyright © 2015 Rishi Kapadia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTaskViewControllerDelegate {
    
    @IBOutlet
    var tableView: UITableView!
    
    // Sample data, will be erased before view appears
    var items: [String] = ["We", "Heart", "Swift"]
    var completed: [Bool] = [true, true, true]
    var timestamp: [Double] = [0, 0, 0]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        checkAfter24Hours()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell?)!
        
        if completed[indexPath.row] {
            cell.textLabel?.text = self.items[indexPath.row] + "   -   Completed!"
        } else {
            cell.textLabel?.text = self.items[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let i = indexPath.row
        completed[i] = !completed[i]
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            let i = indexPath.row
            items.removeAtIndex(i)
            completed.removeAtIndex(i)
            tableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowStatsSegue"
        {
            if let destinationVC = segue.destinationViewController as? DailyStatsViewController {
                var count = 0
                for e in completed {
                    if e {
                        count++
                    }
                }
                destinationVC.numberToDisplay = count
            }
        }
        
        if segue.identifier == "AddTaskSegue"
        {
            /*let navigationController = segue.destinationViewController as? UINavigationController
            let addItemViewController = navigationController?.topViewController as? AddTaskViewController
            
            if let viewController = addItemViewController {
                viewController.delegate = self
            }*/
            let dest = segue.destinationViewController as! AddTaskViewController
            dest.delegate = self
        }
    }
    
    // MARK: Add Item View Controller Delegate Methods
    func controller(controller: AddTaskViewController, didAddItem: String) {
        // Update Data Source
        self.addTask(didAddItem)
        
        // Reload Table View
        self.tableView.reloadData()
        
        // Dismiss Add Item View Controller
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addTask(name: String) {
        let nowDouble = NSDate().timeIntervalSince1970
        items.append(name)
        completed.append(false)
        timestamp.append(nowDouble)
        tableView.reloadData()
    }
    
    func checkAfter24Hours() {
        var i = items.count - 1
        while i >= 0 {
            let ms = NSDate().timeIntervalSince1970 - timestamp[i]
            if completed[i] && ms > 24*60*100 {
                items.removeAtIndex(i)
                completed.removeAtIndex(i)
                timestamp.removeAtIndex(i)
            }
            i--
        }
        tableView.reloadData()
    }
}

