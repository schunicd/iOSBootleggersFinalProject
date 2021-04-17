//
//  SpotlightViewController.swift
//  iOSBootleggersFinalProject
//
//  Created by  on 4/17/21.
//

import UIKit
//importing webkit to be able to display webpages
import WebKit

class SpotlightViewController: ViewController, WKNavigationDelegate{

    @IBOutlet var webView : WKWebView!
    @IBOutlet var activity : UIActivityIndicatorView!
    
    //creating a constant for the appDelegate so that we can access variables
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //creating constants with the uris for each website
    let spotlightOneUri = URLRequest(url: URL(string: "https://patreon.com/themoonshinecafe")!)
    let spotlightTwoUri = URLRequest(url: URL(string: "https://facebook.com/events/439127044174856")!)
    
    //while webview is loading, show activity loading icon
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        activity.isHidden = false
        activity.startAnimating()
    }
    
    //when webview is done loading, stop showing activity loading icon
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        activity.isHidden = true
        activity.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(appDelegate.spotlightOneMoreInfo == true){
            webView?.load(spotlightOneUri)
        }
        
        else if(appDelegate.spotlightOneMoreInfo == false){
            webView?.load(spotlightTwoUri)
        }
        
        webView.navigationDelegate = self
        
    }

}
