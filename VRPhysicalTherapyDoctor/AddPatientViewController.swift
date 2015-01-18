//
//  AddPatientViewController.swift
//  VRPhysicalTherapyDoctor
//
//  Created by Aneesh Sachdeva on 1/17/15.
//  Copyright (c) 2015 Applos. All rights reserved.
//

import Foundation

class AddPatientViewController: UIViewController
{
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var addRelationButton: UIButton!
    
    @IBAction func addRelationButtonPressed(sender: AnyObject)
    {
        if PFUser.currentUser() != nil
        {
            let patientUsername : String = usernameTextField.text
            
            var query = PFUser.query()
            query.whereKey("username", equalTo: patientUsername)
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]!, error: NSError!) -> Void in
                if error == nil
                {
                    // The find succeeded.
                    NSLog("Successfully retrieved " + patientUsername + ".")
                    //println(objects.count)
                    
                    // Create relation.
                    if objects.first != nil
                    {
                        let queriedUser : PFUser = objects.first as PFUser
                        
                        if queriedUser["type"] as NSString == "patient"
                        {
                            let relation : PFRelation = PFUser.currentUser().relationForKey("patientDoctorRelations")
                            relation.addObject(queriedUser)
                            
                            PFUser.currentUser().saveInBackground()
                        }
                        else
                        {
                            NSLog("Queried user is not of type patient")
                        }
                    }
                    else
                    {
                        NSLog("Error, queried user is nil")
                    }
                }
                else
                {
                    // Log details of the failure
                    NSLog("Error: %@ %@", error, error.userInfo!)
                }
            }
        }

    }
    
    @IBAction func usernameEntered(sender: AnyObject)
    {
        
    }
    
}