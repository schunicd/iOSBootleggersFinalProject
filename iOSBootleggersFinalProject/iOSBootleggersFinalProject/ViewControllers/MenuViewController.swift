//
//  MenuViewController.swift
//  iOSBootleggersFinalProject
//
//  Created by Harpreet Ghuman on 4/10/21.
//

import UIKit
import WebKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //calls the AppDelegate
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //array for the names of the menu items
    var listData = ["French Fries", "Pulled Pork on a Kaiser", "BBQ Chicken Wings", "Grilled Chicken on a Bun", "BBQ Burger", "BBQ Vegie Burger", "BBQ Sausage on a Bun"]
    //price1 for the items
    var priceData1 = ["$3.75 (small)", "$8.50", "$14.50 (8)", "$8.50", "$8.50", "$8.50", "$7.00"]
    //price2 for the items
    var priceData2 = ["$6.00 (large)", "$10.00 (combo) ", "$17.75 (12)", "$10.00 (combo) ", "$10.00 (combo)", "$10.00 (combo) ", "$9.00 (combo) "]
    //images for the corresponding items
    var imageData = ["frenchfries.png", "PulledPork.png", "BBQChickenWings.png", "GrilledChickenOnBun.png","BBQBurger.png", "BBQVeggieBurger.png", "BBQSausage.png" ]
    //funtion to determine the number of row in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    //function to set the height of the rows in the table
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    //func to use reuse cells, using custom cells as specified in the Site Cell Class
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")//reusing the cells in the table
        
        let rowNum = indexPath.row
        
        tableCell.primaryLabel.text = listData[rowNum] //sets the text value of the row for that index
        tableCell.myImageView.image = UIImage(named: imageData[rowNum])//sets the image of the row at that index
        
        tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
    }
    // function to take the data for the row index and load it to menuItemViewController, using the "chooseSegueToView" identifier to send the data to the correct viewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowNum = indexPath.row
        appDelegate.menuItem = listData[rowNum]
        appDelegate.menuPrice1 = priceData1[rowNum]
        appDelegate.menuPrice2 = priceData2[rowNum]
        appDelegate.menuImage = imageData[rowNum]
        performSegue(withIdentifier: "ChooseSegueToView", sender: self)
        
    }
    
    
    //unwind to the MenuViewController - back button will this storyboard
    @IBAction func unwindToMenuViewController(sender : UIStoryboardSegue){
        
    }
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
