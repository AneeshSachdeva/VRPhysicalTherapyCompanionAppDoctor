//
//  FrisbeeGraphWebViewController.swift
//  VRPhysicalTherapyDoctor
//
//  Created by Aneesh Sachdeva on 1/18/15.
//  Copyright (c) 2015 Applos. All rights reserved.
//

import Foundation

class FrisbeeGraphWebViewController : UIViewController
{
    @IBOutlet weak var WebView: UIWebView!
    
    var urlString : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let url = NSURL(string: urlString!)
        let request = NSURLRequest(URL: url!)
        WebView.loadRequest(request)
    }
    
    func recievePatientUsername(username: String)
    {
        var url = NSURL(string: "http://nikhilkhanna.github.io/")! /*?user=" + username)*/
    }
}