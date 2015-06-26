//
//  PaymentViewController.swift
//  LuckKitchen
//
//  Created by Ping Zhang on 6/13/15.
//  Copyright (c) 2015 Ping Zhang. All rights reserved.
//

import Foundation
import UIKit
import Stripe

class PaymentShippingViewController: UITableViewController, UITextFieldDelegate, STPCheckoutViewControllerDelegate, PKPaymentAuthorizationViewControllerDelegate {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var lastnameLabel: UILabel!
    @IBOutlet var lastnameTextField: UITextField!
    
    @IBOutlet weak var buildingDetail: UILabel!
    @IBOutlet weak var deliverTimeDetail: UILabel!

    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var commentTextView: UITextView!

    @IBOutlet var orderButton: UIButton!
    
    //record all delivery msg
    var deliveryMsg = [String: String]()
    
    @IBAction func saveBuilding(segue:UIStoryboardSegue) {
        if let chooseBuilding = segue.sourceViewController as? ChooseBuildingTableViewController {
            if chooseBuilding.selectedBuilding == nil {
                buildingDetail.text = "Duder MUJO"
                deliveryMsg["building"] = "Duder MUJO"
            }
            else {
                buildingDetail.text = chooseBuilding.selectedBuilding
                deliveryMsg["building"] = buildingDetail.text!
            }
        }
    }
    
    @IBAction func saveDeliverTime(segue:UIStoryboardSegue) {
        if let chooseTime = segue.sourceViewController as? ChooseTimeTableViewController {
            if chooseTime.seletcedTime == nil {
                deliverTimeDetail.text = "Choose time"
                deliveryMsg["time"] = nil
            }
            else {
                deliverTimeDetail.text = chooseTime.seletcedTime
                deliveryMsg["time"] = deliverTimeDetail.text!
            }
        }
    }

    
   
//Stripe
    // Replace these values with your application's keys
    // Find this at https://dashboard.stripe.com/account/apikeys
    let stripePublishableKey = "pk_test_gFcX7XM9Els3YlK17C1Qhj7B"
    // To set this up, see https://github.com/stripe/example-ios-backend
    //let backendChargeURLString = "https://luckkitchen.herokuapp.com"

    var totalPrice : UInt! // this is in cents
    
    @IBAction func beginPayment(sender: UIButton) {
        if let time = deliveryMsg["time"] {
            let options = STPCheckoutOptions(publishableKey: stripePublishableKey)
            options.companyName = "LuckKitchen"
            options.purchaseDescription = "Enjoy your dishes"
            options.purchaseAmount = totalPrice
            options.logoColor = UIColor.purpleColor()
            let checkoutViewController = STPCheckoutViewController(options: options)
            checkoutViewController.checkoutDelegate = self
            presentViewController(checkoutViewController, animated: true, completion: nil)
        }
        else {
            Helper.sendAlert("Please Choose Time!", message: "Please choose a deliver time")
        }
    }
    
    
    func checkoutController(controller: STPCheckoutViewController, didCreateToken token: STPToken, completion: STPTokenSubmissionHandler) {
        createBackendChargeWithToken(token, completion: completion)
    }
    
    func checkoutController(controller: STPCheckoutViewController, didFinishWithStatus status: STPPaymentStatus, error: NSError?) {
        dismissViewControllerAnimated(true, completion: {
            switch(status) {
            case .UserCancelled:
                return // just do nothing in this case
            case .Success:
                Helper.sendAlert("Payment Succeeded!", message: "Thank you for purchasing!")
                println("great success!")
                
            case .Error:
                Helper.sendAlert("Payment Failed", message: "Please try again, thanks!")
                println("oh no, an error: \(error?.localizedDescription)")
            }
        })
    }
    
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: ((PKPaymentAuthorizationStatus) -> Void)) {
        let apiClient = STPAPIClient(publishableKey: stripePublishableKey)
        apiClient.createTokenWithPayment(payment, completion: { (token, error) -> Void in
            if error == nil {
                if let token = token {
                    self.createBackendChargeWithToken(token, completion: { (result, error) -> Void in
                        if result == STPBackendChargeResult.Success {
                            completion(PKPaymentAuthorizationStatus.Success)
                            return
                        }
                    })
                }
            }
            completion(PKPaymentAuthorizationStatus.Failure)
        })
    }
    
    func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController!) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func createBackendChargeWithToken(token: STPToken, completion: STPTokenSubmissionHandler) {
        if BackendUrl.url != "" {
            if let url = NSURL(string: BackendUrl.url  + "/charge") {
                let chargeParams : [String: AnyObject] = ["stripeToken": token.tokenId, "amount": totalPrice]
                
                // This uses Alamofire to simplify the request code. For more information see github.com/Alamofire/Alamofire
                request(.POST, url, parameters: chargeParams)
                    .responseJSON { (_, response, _, error) in
                        if response?.statusCode == 200 {
                            completion(STPBackendChargeResult.Success, nil)
                        } else {
                            completion(STPBackendChargeResult.Failure, error)
                        }
                }
                return
            }
        }
        completion(STPBackendChargeResult.Failure, NSError(domain: StripeDomain, code: 50, userInfo: [NSLocalizedDescriptionKey: "You created a token! Its value is \(token.tokenId). Now configure your backend to accept this token and complete a charge."]))
    }
//end Stripe
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeLabelWithText(nameLabel, text: "FIRST NAME")
        themeTextFieldWithText(nameTextField, text: "John")
        
        themeLabelWithText(lastnameLabel, text: "LAST NAME")
        themeTextFieldWithText(lastnameTextField, text: "Harrison")
        
        themeLabelWithText(commentLabel, text: "COMMENT")

        commentTextView.font = UIFont(name: MegaTheme.fontName, size: 10)
        commentTextView.textColor = MegaTheme.darkColor
        commentTextView.text = "Please leave a comment here"
        
        orderButton.titleLabel?.font = UIFont(name: MegaTheme.boldFontName, size: 18)
        orderButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        orderButton.setTitle("PLACE ORDER", forState: .Normal)
        orderButton.backgroundColor = UIColor(red: 0.14, green: 0.71, blue: 0.69, alpha: 1.0)
        orderButton.layer.cornerRadius = 20
        orderButton.layer.borderWidth = 0;
        orderButton.clipsToBounds = true;
        
        //println("here")
    }
    
    func themeTextFieldWithText(textField:UITextField, text: String){
        let largeFontSize : CGFloat = 17
        textField.font = UIFont(name: MegaTheme.fontName, size: largeFontSize)
        textField.textColor = MegaTheme.darkColor
        textField.text = text
        textField.delegate = self
    }
    
    func themeLabelWithText(label: UILabel, text: String){
        let fontSize : CGFloat = 10
        label.font = UIFont(name: MegaTheme.fontName, size: fontSize)
        label.textColor = MegaTheme.lightColor
        label.text = text
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return 120
        }else if indexPath.row == 4 {
            return 80
        }
        return 60
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //self.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //self.deregisterFromKeyboardNotifications()
    }
    
    
    func registerForKeyboardNotifications ()-> Void   {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
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
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        cell.selectionStyle = .None
    }
    
    override func viewDidLayoutSubviews() {
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layoutMargins = UIEdgeInsetsZero
    }
}
