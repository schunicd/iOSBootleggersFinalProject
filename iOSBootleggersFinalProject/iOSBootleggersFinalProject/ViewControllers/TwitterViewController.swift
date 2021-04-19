//
//  TwitterViewController.swift
//  iOSBootleggersFinalProject
//
//  Created by Harpreet Ghuman on 4/18/21.
//

import UIKit
import WebKit

class TwitterViewController: UIViewController {
    
    //variables needed to run the function that will load the twitter feed to the webview.  the Twitter SDK has been deprecated
    var twitterFeed: WKWebView!
    var configuration = WKWebViewConfiguration()
    
    override func loadView()
    {
        //sets the frame for the twitter feed
        twitterFeed = WKWebView(frame: CGRect( x: 0, y: 700, width: 400, height: 50 ), configuration: configuration)
        //self.view.addSubview(twitterFeed)
        twitterFeed.configuration.preferences.javaScriptEnabled = true
        view = twitterFeed
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startLoad()//load function when loading the viewController

        // Do any additional setup after loading the view.
    }
    //function to load twitter feed
    private func startLoad()
    {
        twitterFeed.load(URLRequest(url: URL(string: "https://twitter.com/MoonshineCafe")!))
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
