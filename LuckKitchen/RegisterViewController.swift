//
//  RegisterViewController.swift
//  LuckKitchen
//
//  Created by Ping Zhang on 6/13/15.
//  Copyright (c) 2015 Ping Zhang. All rights reserved.
//

import UIKit


class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var passWordRepeat: UITextField!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var telephone: UITextField!
    
    //String contains error msg
    private func checkEmail() -> (result: Bool, error: String) {
        if let email = emailInput.text {
            if email.isEmail {
                return (true, "")
            }
        }
        return (false, "Email is invalid")
    }
    
    private func checkPassword() -> (result: Bool, error: String) {
        if let firstPsw = passwordInput.text{
            if let repeatPsw = passWordRepeat.text {
                if firstPsw == repeatPsw && count(firstPsw) >= 6{
                    return (true, "")
                }
            }
        }
        return (false, "Invalid password")
    }
    
    @IBAction func registerUser(sender: UIButton) {
        let emailCheckedRes = checkEmail()
        let pswCheckedRes = checkPassword()
        //var displayMessage: String = "Register Succeeded, please go to log in!"
        if(emailCheckedRes.result && pswCheckedRes.result) {
            //send request to server
            let registerParams = ["email": emailInput.text!, "psw": passwordInput.text!, "name": usernameInput.text!, "tel": telephone.text!]
            request(.POST, "http://localhost:9292/register", parameters: registerParams)
                .response { (request, response, data, error) in
                    if response?.statusCode != 200 {
                        if response?.statusCode == 501 {
                            Helper.sendAlert("Register Result", message: "User already exits")
                        }
                        else {
                            Helper.sendAlert("Register Result", message: "Unknown error in the server, please try later")
                        }
                    }
            }
        }
        else {
            Helper.sendAlert("Register Result", message: emailCheckedRes.error + " \n " + pswCheckedRes.error)
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
