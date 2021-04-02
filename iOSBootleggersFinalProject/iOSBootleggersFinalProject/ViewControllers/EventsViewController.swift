//
//  EventsViewController.swift
//  iOSBootleggersFinalProject
//
//  Created by  on 3/31/21.
//

import UIKit
import WebKit

class EventsViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var webView : WKWebView!
    @IBOutlet var activity : UIActivityIndicatorView!
    @IBOutlet var SpotlightImage_One : UIImageView!
    @IBOutlet var SpotlightImage_Two : UIImageView!
    
    let uri = "https://calendar.google.com/calendar/embed?src=themoonshinecafe%40gmail.com&ctz=America%2FToronto"
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        activity.isHidden = false
        activity.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        activity.isHidden = true
        activity.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        let urlAddress = URLRequest(url: URL(string: uri)!)
        
        SpotlightImage_One.image = UIImage(named: "artist1.jpg");
        SpotlightImage_Two.image = UIImage(named: "artist2.jpg");
        
        webView?.load(urlAddress)
        webView.navigationDelegate = self
        

        // Do any additional setup after loading the view.
    }
    

}
