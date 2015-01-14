//
//  ViewController.swift
//  Memento
//
//  Created by Vasil on 15.01.15.
//  Copyright (c) 2015 vasil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableData : [NSString] {
        get {
            var returnValue: [NSString]? = NSUserDefaults.standardUserDefaults().objectForKey("tableData") as? [NSString]
            if returnValue == nil //Check for first run of app
            {
                returnValue = [] //Default value
            }
            return returnValue!
        }
        set (newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "tableData")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        let date = dateFormatter.stringFromDate(NSDate())
        textView.text = "\(date) - "
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelectionDuringEditing = false;
    }
    
    @IBAction func addButtonDidPress(sender: AnyObject) {
        tableData.append(textView.text)
        refreshTable()
        textView.resignFirstResponder()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: simpleTableIdentifier)
        }
        cell?.textLabel?.text = tableData[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            tableData.removeAtIndex(indexPath.row)
            refreshTable()
        }
    }
    
    func refreshTable() {
        tableView.reloadData()
        tableView.reloadRowsAtIndexPaths(tableView.indexPathsForVisibleRows()!, withRowAnimation: UITableViewRowAnimation.None)
    }
}

let simpleTableIdentifier = "SimpleTableItem"

