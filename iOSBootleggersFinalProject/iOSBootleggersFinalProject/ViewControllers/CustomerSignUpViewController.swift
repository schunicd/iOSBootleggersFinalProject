//
//  CustomerSignUpViewController.swift
//  iOSBootleggersFinalProject
//
//  Created by Lucas Zanlorensi on 2021-04-18.
//

import UIKit

class CustomerSignUpViewController : UIViewController {
    
    @IBOutlet var firstNameTxt: UITextField!
    @IBOutlet var lastNameTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var submitBtn: UIButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func submitInfoToNewsletter(){
        let alert: UIAlertController
        
        if firstNameTxt.text!.isEmpty || lastNameTxt.text!.count == 0 || emailTxt.text!.count == 0{
            alert = UIAlertController(title: "Required", message: "Please fill in all the information", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            alert = UIAlertController(title: "Success", message: "Thank you for signing up for the newsletter!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
            let myData: Data = Data()
            myData.initWithData(theRow: 1, theFirstName: firstNameTxt.text!, theEmail: emailTxt.text!, theLastName: lastNameTxt.text!)
            if appDelegate.insertIntoDatabase(entry: myData){
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        
    }
}
