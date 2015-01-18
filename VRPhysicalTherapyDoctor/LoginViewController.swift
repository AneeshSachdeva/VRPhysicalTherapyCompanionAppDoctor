//
//  LoginViewController.swift
//  ParseLoginTestSwift
//
//  Created by Aneesh Sachdeva on 1/2/15.
//  Copyright (c) 2015 Applos. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate
{
    
    @IBOutlet weak var loginStatusLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonPress(sender: AnyObject)
    {
        login(emailTextField.text, password: passwordTextField.text)
    }
    
    func login(email: String, password: String)
    {
        PFUser.logInWithUsernameInBackground(email, password: password)
        {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil
            {
                user.fetch()
                if user.objectForKey("emailVerified") as Bool
                {
                    self.loginStatusLabel.text = "Success!"
                }
                else if !(user.objectForKey("emailVerified") as Bool)
                {
                    self.loginStatusLabel.text = "Verify your email address!"
                }
                else // status is "missing"
                {
                    //TODO: Handle this error better
                    self.loginStatusLabel.text = "Verification status: Missing"
                }

            }
            else
            {
                if let errorField = error.userInfo
                {
                    self.loginStatusLabel.text = (errorField["error"] as NSString)
                }
                else
                {
                    // No userInfo dictionary present
                    // Help from http://stackoverflow.com/questions/25381338/nsobject-anyobject-does-not-have-a-member-named-subscript-error-in-xcode
                }

            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
