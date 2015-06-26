//
//  CartViewController.swift
//  LuckKitchen
//
//  Created by Ping Zhang on 6/12/15.
//  Copyright (c) 2015 Ping Zhang. All rights reserved.
//

import Foundation
import UIKit

class CartViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var totalLabel : UILabel!
    @IBOutlet var totalTitle : UILabel!
    @IBOutlet var orderButton : UIButton!
    
    var activeTextField: UITextField!

    var selectedProduct: Product!
    var productsInCart: [ProductsInCart]!
    //core data
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        totalTitle.font = UIFont(name: MegaTheme.fontName, size: 15)
        totalTitle.textColor = UIColor.blackColor()
        totalTitle.text = "TOTAL"
        
        totalLabel.font = UIFont(name: MegaTheme.fontName, size: 15)
        totalLabel.textColor = UIColor.blackColor()
        totalLabel.text = calculateTotal()
        
        orderButton.titleLabel?.font = UIFont(name: MegaTheme.boldFontName, size: 18)
        orderButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        orderButton.setTitle("PLACE ORDER", forState: .Normal)
        orderButton.backgroundColor = UIColor(red: 0.14, green: 0.71, blue: 0.32, alpha: 1.0)
        orderButton.layer.cornerRadius = 20
        orderButton.layer.borderWidth = 0;
        orderButton.clipsToBounds = true;
        
        //create a update cart
        let rightBarItem = UIBarButtonItem(title: "Update Cart", style: .Plain, target: self, action: Selector("updateCart"))
        navigationItem.rightBarButtonItem = rightBarItem
        
        //go to dish
        let leftBarItem = UIBarButtonItem(title: "Dishes", style: .Plain, target: self, action: Selector("showShopView"))
        navigationItem.leftBarButtonItem = leftBarItem
    }
    
    func showShopView() {
        performSegueWithIdentifier("cartToShop", sender: self)
    }
    
    func calculateTotal() -> String {
        if productsInCart == nil {
            return "0"
        }
        var total: Double = 0
        for product in productsInCart {
            let qty = product.qty
            total += Double(qty) *  Helper.strToDouble(product.price)!
        }
        return String(format:"%.3f", total)
    }
    
    //?
    func updateCart() {
        //1. send updated info to database
        //2. get new data
        //3. display them
        //the following line will dismiss the number board
        self.view.endEditing(true)
        Helper.sendAlert("Updated the cart!", message: "Your shopping cart has been updated")
        tableView.reloadData()
    }
    
    //the following function is used to delete cell when user swipes the cell to his left
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("CartCell") as! CartCell
        switch editingStyle {
        case .Delete:
            let productToBeDeleted = productsInCart[indexPath.row]
            //delete persisting data
            managedObjectContext?.deleteObject(productToBeDeleted)
            self.productsInCart.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            //update total
            totalLabel.text = "$" + calculateTotal()
        default:
            return
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productsInCart == nil {
            return 0
        }
        else {
            return productsInCart.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CartCell") as! CartCell
        //the following line is very important
        cell.quantityTextField.delegate = self
        
        let product = productsInCart[indexPath.row]
        cell.productImageView.image = UIImage(named: product.image)
        cell.titleLabel.text = product.title
        cell.detailsLabel.text = "detail title " + product.title
        cell.priceLabel.text = "$" + product.price
        //this will update the productsInCart!!, after user updates the qty
        //because here I set cell.quanityTextField.text's default is "-1", so that I need to check "-1"
        //and I can make sure that this will never be zero unless user changes it
        if(cell.quantityTextField.text == nil || cell.quantityTextField.text == "-1") {
            let qty = product.qty
            cell.quantityTextField.text = product.qty.description
            
        }
        else {
            //here I will update the productsInCart
            //but after these I need to push all the information to the server
            //how to do this???
            //I may do this before I call tableView.reloadData(), no you cannot! because here is the place you update the productsInCart
            var cellQty =  cell.quantityTextField.text
            //cellQty != "" can check user puts nothing
            if cellQty != nil && cellQty != ""{
                productsInCart[indexPath.row].qty =  cellQty!.toInt()!
            }
            else {
                productsInCart[indexPath.row].qty = 0
                cell.quantityTextField.text = "0"
                //leaving 0 here is actually better than deleting it, because user might change its idea, thi will recover it more easily
            }
        }
        //this section will update the total after displaying the last cell
        if indexPath.row == productsInCart.count - 1 {
            totalLabel.text = "$" + calculateTotal()
        }
        return cell
    }
    
    //get the active UITextField
    func textFieldDidBeginEditing(textField: UITextField) {
        activeTextField = textField
    }
    func textFieldDidEndEditing(textField: UITextField) {
        activeTextField = nil
    }
    //the second way to perform segue
    //if you want to carry something to next viewController with some info
    //and see below!
    //1. first use select... to get the info you want
    //2. prepareForSegue, to set the info in next viewController
    //3. finally call performSegueWIth... in the 1. step's function
    //of course you need add a segue from this viewController to the next viewController
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //reset activeTextField to nil and when user touch this cell, he doesn't mean to go to product details. He just want to dismiss the the number pad
        if activeTextField != nil {
            activeTextField.resignFirstResponder()
            activeTextField = nil
        }
        else {
            //mark the selected product and prepare pass from the selectedProduct to the next view controller in prepareForSegue
            var p = productsInCart[indexPath.row]
            
            selectedProduct = Product(title: p.title, price: p.price, image: p.image)
            self.performSegueWithIdentifier("cartToProductDetail", sender: self)
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "cartToProductDetail" {
            var productDetailController = (segue.destinationViewController as! ProductDetailViewController)
            //here is a upcasting
            productDetailController.selectedProduct = selectedProduct
        }
    }
    
    
    //the following functions are used to solve keyboard covering TextField, which is quite
    //standard
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(false)
        self.registerForKeyboardNotifications()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(false)
        self.deregisterFromKeyboardNotifications()
    }
    func registerForKeyboardNotifications ()-> Void   {
        let center:  NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        
        center.addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    func deregisterFromKeyboardNotifications () -> Void {
        let center:  NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.removeObserver(self, name: UIKeyboardDidHideNotification, object: nil)
        center.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    func keyboardWasShown(notification: NSNotification) {
        
        let info : NSDictionary = notification.userInfo!
        let keyboardSize = info.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue().size
        let insets: UIEdgeInsets = UIEdgeInsetsMake(self.tableView.contentInset.top, 0, keyboardSize!.height, 0)
        
        self.tableView.contentInset = insets
        self.tableView.scrollIndicatorInsets = insets
        
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, self.tableView.contentOffset.y + keyboardSize!.height)
    }
    func keyboardWillBeHidden (notification: NSNotification) {
        
        let info : NSDictionary = notification.userInfo!
        let keyboardSize = info.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue().size
        let insets: UIEdgeInsets = UIEdgeInsetsMake(self.tableView.contentInset.top, 0, keyboardSize!.height, 0)
        
        self.tableView.contentInset = insets
        self.tableView.scrollIndicatorInsets = insets
    }
}


