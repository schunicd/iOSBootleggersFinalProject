//
//  TwitterViewController.swift
//  iOSBootleggersFinalProject
//
//  Created by Harpreet Ghuman on 4/18/21.
//

import UIKit
import WebKit

class TwitterViewController: UIViewController, WKNavigationDelegate {
    
    //variables needed to run the function that will load the twitter feed to the webview.  the Twitter SDK has been deprecated
    
    @IBOutlet var webView : WKWebView!
    @IBOutlet var activity : UIActivityIndicatorView!
    
    let uri = "https://twitter.com/MoonshineCafe"
    
    //when the web view is loading, show the loading icon and animate it
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        activity.isHidden = false
        activity.startAnimating()
    }
    
    //when the web view is done loading, stop showing the loading icon and stop animating it
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        activity.isHidden = true
        activity.stopAnimating()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlAddress = URLRequest(url: URL(string: uri)!)
        
        webView?.load(urlAddress)
        webView.navigationDelegate = self

        // Do any additional setup after loading the view.
    }


}
