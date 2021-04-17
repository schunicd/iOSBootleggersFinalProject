//
//  EventsViewController.swift
//  iOSBootleggersFinalProject
//
//  Created by Derek Schunicke on 3/31/21.
//
//  I started out researching Google Calendar, and what ways they would allow me to integrate
//  one of their calendars into my app. They have 4 options, using calendar ID, a Public URL to
//  the calendar, code to embed the calendar in your webpage, and a public address in iCal format.
//  Through researching xCode UI Components, I learned there wasnt a calendar component available.
//  This meant I wouldn't be able to use the iCal option, as I need an application such as a calendar
//  that can process the information. I decided to use a webkit view to display the calendar, as
//  this seemed like the most sensible way to add a Google Calendar into my application with the
//  resources provided to me from Google Calendar.

import UIKit
//importing webkit view to display the google calendar
import WebKit

//extending WKNavigationDelegate to allow users the ability to navigate the Google Calendar
class EventsViewController: UIViewController, WKNavigationDelegate {

    @IBAction func unwindToEventController(sender : UIStoryboardSegue){
        
    }
    
    //creating outlets to connect to the web view, and the loading icon
    @IBOutlet var webView : WKWebView!
    @IBOutlet var activity : UIActivityIndicatorView!
    
    //creating outlets to connect to the labels for displaying the first item in the spotlight
    @IBOutlet var SpotlightImage_One : UIImageView!
    @IBOutlet var EventLabel_One : UILabel!
    @IBOutlet var DateLabel_One : UILabel!
    @IBOutlet var DescriptionLabel_One : UILabel!
    
    //creating outlets to connect to the labels for displaying the second item in the spotlight
    @IBOutlet var SpotlightImage_Two : UIImageView!
    @IBOutlet var EventLabel_Two : UILabel!
    @IBOutlet var DateLabel_Two : UILabel!
    @IBOutlet var DescriptionLabel_Two : UILabel!
    
    //creating a constant for the appDelegate so that we can access variables
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //creating uri for the Google Calendar
    let uri = "https://calendar.google.com/calendar/embed?src=themoonshinecafe%40gmail.com&ctz=America%2FToronto"
    
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
    
    //function to navigate when touch begins to new view controller and display web view for spotlight event
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //declaring variables for touch event
        let touch : UITouch = touches.first!
        let touchPoint : CGPoint = touch.location(in: self.view!)
        
        //getting the frame area of each label so we can see if they clicked the correct label
        let eventOneFrame : CGRect = EventLabel_One.frame
        let eventTwoFrame : CGRect = EventLabel_Two.frame
        
        //if the event one frame is clicked set spotlightOneMoreInfo to true and navigate to
        //SpotlightViewController/spotlightViewStoryboard
        if eventOneFrame.contains(touchPoint){
            appDelegate.spotlightOneMoreInfo = true
            performSegue(withIdentifier: "SpotlightOneSegueToWebview", sender: self)
        }
        
        //if the event two frame is clicked set spotlightOneMoreInfo to false and navigate to
        //SpotlightViewController/spotlightViewStoryboard
        if eventTwoFrame.contains(touchPoint){
            appDelegate.spotlightOneMoreInfo = false
            performSegue(withIdentifier: "SpotlightTwoSegueToWebview", sender: self)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set the url address for the Google calendar webkit view
        let urlAddress = URLRequest(url: URL(string: uri)!)
        
        //setting values for spotlight one to display
        SpotlightImage_One.image = UIImage(named: "artist1.jpg")
        EventLabel_One.text = "MOONSHINE ON PATREON"
        DateLabel_One.text = "OPEN"
        DescriptionLabel_One.text = "For a modest monthly or annual subscription amount you can support The Moonshine Cafe while enjoying Live Streamed Events as they happen, or watching them at your convenience and access our archived shows. We have invested in hardware, software and the learning curve to be able to provide a polished production to our PATRONS."
        
        //setting values for spotlight two to display
        SpotlightImage_Two.image = UIImage(named: "artist2.jpg")
        EventLabel_Two.text = "Mary Simon Live Stream"
        DateLabel_Two.text = "MAR 19 @ 8PM"
        DescriptionLabel_Two.text = "Playing the music she's written and produced over the last 20 yrs. Mary will be joined by MISSISSIPPI BENDS. This great Canadian Zydeco Band from 8-10PM Sadly.. No Jambalaya and Corn Bread this year, but the show will be great."
        
        //load the webkit view of the Google Calendar, and allow users to navigate within the webkit view
        webView?.load(urlAddress)
        webView.navigationDelegate = self
        
    }

}
