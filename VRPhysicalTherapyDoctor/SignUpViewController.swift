//
//  ViewController.swift
//  ParseLoginTestSwift
//
//  Created by Aneesh Sachdeva on 1/1/15.
//  Copyright (c) 2015 Applos. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        emailTextField.delegate = self;
        passwordTextField.delegate = self;
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccountButtonPressed(sender: AnyObject)
    {
        if verifyEmailDomain(self.emailTextField.text)
        {
            createAccount(self.emailTextField.text, password: self.passwordTextField.text)
        }
        else
        {
            //self.statusLabel.text = "Email domain is not valid.";
            
            let alert = UIAlertView()
            alert.title = "Invalid Email Domain"
            alert.message = "Make sure you entered in your address correctly. If you did, ask your system about using VRTherapy! Thanks."
            alert.addButtonWithTitle("Close")
            alert.show()
        }
        
        
    }
    
    func verifyEmailDomain(email: String) -> Bool
    {
        var isVerifiedDomain = false
        let userDomain: String = (email.componentsSeparatedByString("@")).last!
        
        //NSLog(userDomain)
        
        let validDomainsFileLocation = NSBundle.mainBundle().pathForResource("ValidVRDomains", ofType: "txt")
        var validDomainsFileContent = NSString(contentsOfFile: validDomainsFileLocation!, encoding: NSUTF8StringEncoding, error: nil)
        
        //NSLog(validDomainsFileContent!)
        
        let validDomains = validDomainsFileContent!.componentsSeparatedByString("\n")
        for domain in validDomains
        {
            NSLog(domain as NSString)
            
            if userDomain == (domain as NSString)
            {
                isVerifiedDomain = true
                break
            }
        }
        
        return isVerifiedDomain
    }
    
    func createAccount(email: String, password: String)
    {
        var newUser = PFUser()
        
        newUser.username = email // We want the user to login only with their email.
        newUser.email = email
        newUser.password = password
        newUser["type"] = "doctor"
        //newUser["patientsMonitered"] = [PFUser]()
        
        newUser.signUpInBackgroundWithBlock { (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil
            {
                // Account created successfully!
                if succeeded == true
                {
                    self.statusLabel.text = "Account created!"
                }
            }
            else
            {
                if let errorField = error.userInfo
                {
                    self.statusLabel.text = (errorField["error"] as NSString)
                }
                else
                {
                    // No userInfo dictionary present
                    // Help from http://stackoverflow.com/questions/25381338/nsobject-anyobject-does-not-have-a-member-named-subscript-error-in-xcode
                }
            }
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
}

