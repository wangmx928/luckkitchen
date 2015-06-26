//
//  ECommerceSelectorController.swift
//  LuckKitchen
//
//  Created by Ping Zhang on 6/12/15.
//  Copyright (c) 2015 Ping Zhang. All rights reserved.
//

import Foundation

import UIKit

class eCommerceSelectorController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
    
    var viewLinks : [ViewInfo]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewLinks = [ViewInfo]()
        viewLinks.append(ViewInfo(title: "Go Shopping", segue: "shop" ,description: "See all products"))
        
        viewLinks.append(ViewInfo(title: "Incoming Dishes", segue: "eToCart", description: "Rows of shopping cart items with product details"))
//        
//        viewLinks.append(ViewInfo(title: "Order Info", segue: "order", description: "Configurable Table of Order details"))
//        viewLinks.append(ViewInfo(title: "Shipping Detail", segue: "orderdetail", description: "Credit Card, CCV and Shipping Info"))
        let rightItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: "logout:")
        navigationItem.rightBarButtonItem = rightItem
        //this will hide back button
        navigationItem.hidesBackButton = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewLinks.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MetaCell") as! MetaCell
        
        let info = viewLinks[indexPath.row]
        cell.titleLabel.text = info.title
        cell.subtitleLabel.text = info.description
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let info = viewLinks[indexPath.row]
        self .performSegueWithIdentifier(info.segue, sender: self)
    }
    
    func logout(sender: AnyObject?){
        
        var alertView: UIAlertView = UIAlertView()
        alertView.title = "Logout"
        alertView.message = "You have been loged out!"
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.show()
        performSegueWithIdentifier("logoutToLogin", sender: self)
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
}