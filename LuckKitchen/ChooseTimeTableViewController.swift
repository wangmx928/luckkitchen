//
//  ChooseCampusTableViewController.swift
//  LuckKitchen
//
//  Created by Ping Zhang on 6/18/15.
//  Copyright (c) 2015 Ping Zhang. All rights reserved.
//

import UIKit

class ChooseTimeTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var timeSlots: [String]!
    var seletcedTime: String? = nil
    var selectedTimeIndex: Int? = nil
    
    func loadTimeSlots() {
        timeSlots = ["11:30", "12:00", "12:30", "13:00", "13:30"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        loadTimeSlots()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return timeSlots.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("TimeCell", forIndexPath: indexPath)
                as! UITableViewCell
            cell.textLabel?.text = timeSlots[indexPath.row]
            if indexPath.row == selectedTimeIndex {
                cell.accessoryType = .Checkmark
            }
            else {
                cell.accessoryType = .None
            }
            return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //Other row is selected - need to deselect it
        if let index = selectedTimeIndex {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            cell?.accessoryType = .None
        }
        
        //if this cell is already selected, it should be deselected
        
        selectedTimeIndex = indexPath.row
        seletcedTime = timeSlots[indexPath.row]
        
        //update the checkmark for the current row
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
        
    }
    
    
}
