//
//  ViewController.swift
//  LuckKitchen
//
//  Created by Ping Zhang on 6/12/15.
//  Copyright (c) 2015 Ping Zhang. All rights reserved.
//

import UIKit

//check emails
extension String {
    var isEmail: Bool {
        let regex = NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .CaseInsensitive, error: nil)
        return regex?.firstMatchInString(self, options: nil, range: NSMakeRange(0, count(self))) != nil
    }
}


class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    //login and verify the process
    @IBAction func login(sender: UIButton) {
        //for test
        self.performSegueWithIdentifier("successfulLogin", sender: self)
 /*
        var email = emailInput.text
        var psw = passwordInput.text

        //here I will get the user's information, and then send a request to my server to check.
        let loginParameters = ["email": email, "psw": psw]
        if email.isEmail {
            request(.POST, "http://localhost:9292/login", parameters: loginParameters)
                .response { (request, response, data, error) in
                    if response?.statusCode == 200 {
                        //save the user's email address
                        let userLoginEmail = NSUserDefaults.standardUserDefaults()
                        userLoginEmail.setObject(email, forKey: "userEmail")
                        self.performSegueWithIdentifier("successfulLogin", sender: self)
                    }
                    else {
                        Helper.sendAlert("Log in Failed!", message: "Please enter valid Username and Password")
                    }
                }
        }
        else {
            Helper.sendAlert("Log in Failed!", message: "Please enter valid Username and Password")
        }
*/
    }
    
    //when user clicks return, the keyboard should disappear
    //first, you need add UITextFieldDelegate
    //second, hold control and drag text to viewController and choose delegate
    //finally, add the following codes
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class ViewInfo {
    var title: String!
    var segue:  String!
    var description:  String!
    
    init(title: String, segue: String){
        self.title = title
        self.segue = segue
    }
    
    init(title: String, segue: String, description: String){
        self.title = title
        self.segue = segue
        self.description = description
    }
}


