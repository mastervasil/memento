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
    
    let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.blackColor().CGColor
        resetText()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelectionDuringEditing = false;
    }
    
    func resetText() {
        let date = dateFormatter.stringFromDate(NSDate())
        textView.text = "\(date) - "

    }
    
    @IBAction func addButtonDidPress(sender: AnyObject) {
        tableData.append(textView.text)
        refreshTable()
        textView.resignFirstResponder()
    }
    
    @IBAction func revertButtonDidPress(sender: AnyObject) {
        resetText()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: simpleTableIdentifier)
        }
        cell?.textLabel?.text = tableData[tableData.count - indexPath.row - 1]
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.sizeToFit()
        return cell!
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            tableData.removeAtIndex(tableData.count - indexPath.row - 1)
            refreshTable()
        }
    }
    
    func refreshTable() {
        tableView.reloadData()
        tableView.reloadRowsAtIndexPaths(tableView.indexPathsForVisibleRows()!, withRowAnimation: UITableViewRowAnimation.None)
    }
}

let simpleTableIdentifier = "SimpleTableItem"

