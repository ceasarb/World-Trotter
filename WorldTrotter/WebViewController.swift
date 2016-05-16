//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Ceasar Barbosa on 3/6/16.
//  Copyright © 2016 Ceasar Barbosa. All rights reserved.
//

import UIKit
import WebKit

class WebViewController : UIViewController {
    
    var webView: WKWebView?
    
    override func loadView() {
        super.loadView()
        
        self.webView = WKWebView()
        self.view = self.webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url =  NSURL(string: "https://www.bignerdranch.com")
        let req = NSURLRequest(URL: url!)
        
        self.webView?.loadRequest(req)
    }
    
    
}
