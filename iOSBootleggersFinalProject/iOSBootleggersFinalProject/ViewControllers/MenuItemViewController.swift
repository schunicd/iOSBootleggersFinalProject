//
//  MenuItemViewController.swift
//  iOSBootleggersFinalProject
//
//  Created by Harpreet Ghuman on 4/10/21.
//

import UIKit

class MenuItemViewController: UIViewController {
    
    //access the AppDelgate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
   //variable that will automatically load with menu item selected from the Menu table
    @IBOutlet var itemName : UILabel!
    @IBOutlet var itemImage : UIImage!
    @IBOutlet var itemPrice : UISegmentedControl!
    @IBOutlet var itemImageView : UIImageView!
    @IBOutlet var navTitle : UINavigationBar!
    
    //func to set the of the nav bar, it will changes each time it is loaded with the corresponding item selected in the table
    func setTitle()
    {
        itemName.text = appDelegate.menuItem
        navTitle.topItem?.title = itemName.text
    }
    //func to set the image in the UI Imabe View in the storyboard
    func setImage()
    {
        //sets the frame of the image view
        self.itemImageView = UIImageView(frame: CGRect(x: 5, y: 50, width: 400, height: 400))
        //allocates the image associated for the item selected
        itemImage = UIImage( named: appDelegate.menuImage)
        //inserts the image into the image view
        itemImageView.image = itemImage
        self.view.addSubview(itemImageView)
        itemImageView.backgroundColor = .white
    }
    
    //function to set the name of the item selected
    func setName()
    {
        itemName.text = appDelegate.menuItem
        itemName.textAlignment = .center
        itemName.backgroundColor = .clear
        itemName.font = UIFont.boldSystemFont(ofSize: 20)
        
    }
    
    //function to set the two prices in the segmented control
    func setPrice()
    {
        itemPrice.setTitle(appDelegate.menuPrice1, forSegmentAt: 0)
        itemPrice.setTitle(appDelegate.menuPrice2, forSegmentAt: 1)
    }
    //function to load the item and price that customer would like to order
    @IBAction func sendOrder(sender: UIButton)
    {
        let itemPriceIndex = self.itemPrice.selectedSegmentIndex //which index was selected
        let price = self.itemPrice.titleForSegment(at: itemPriceIndex)//sets the price according to the title of the selected index
        let alertbox = UIAlertController(title: "Send Order", message: "You ordered " + itemName.text! + " " + price!, preferredStyle: .alert) //shows what was ordered and the selection made
        let noAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) in self.confirmKitchen()
            })       
        
        alertbox.addAction(noAction)
        alertbox.addAction(yesAction)
        present(alertbox, animated: true)
        
    }
    //function to create another alert inside the sendOrder alert confirmation that the order has been sent to the kitchen
    @IBAction func confirmKitchen(){
        let alertController = UIAlertController.init(title: "Order Sent", message: "Order has been sent to the kitchen.  Your server will bring it to your table shortly!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil)
            )
            self.present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //functions that will load on startup and populate with information selected in previous storyboard
        setImage()
        setName()
        setPrice()
        setTitle()
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
