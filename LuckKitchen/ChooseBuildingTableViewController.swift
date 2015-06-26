//
//  ChooseCampusTableViewController.swift
//  LuckKitchen
//
//  Created by Ping Zhang on 6/18/15.
//  Copyright (c) 2015 Ping Zhang. All rights reserved.
//

import UIKit

class ChooseBuildingTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var buildings: [String]!
    var selectedBuilding: String? = nil
    var selectedBuildingIndex: Int? = nil
    
    func loadBuildings() {
        buildings = ["Duder MUJO", "BBB Lobby", "EECS Lobby", "GGB Addition", "FXB Lobby"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        loadBuildings()
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
        return buildings.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("BuildingCell", forIndexPath: indexPath)
                as! UITableViewCell
            cell.textLabel?.text = buildings[indexPath.row]
            if indexPath.row == selectedBuildingIndex {
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
        if let index = selectedBuildingIndex {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            cell?.accessoryType = .None
        }
        
        //if this cell is already selected, it should be deselected
        
        selectedBuildingIndex = indexPath.row
        selectedBuilding = buildings[indexPath.row]
        
        //update the checkmark for the current row
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
        
    }


}
