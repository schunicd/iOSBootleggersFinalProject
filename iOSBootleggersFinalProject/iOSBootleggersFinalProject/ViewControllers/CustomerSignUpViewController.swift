//
//  CustomerSignUpViewController.swift
//  iOSBootleggersFinalProject
//
//  Created by Lucas Zanlorensi on 2021-04-18.
//

import UIKit

class CustomerSignUpViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet var firstNameTxt: UITextField!
    @IBOutlet var lastNameTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var submitBtn: UIButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func submitInfoToNewsletter(){
        let alert1: UIAlertController
        let alert2: UIAlertController
        
        if firstNameTxt.text!.isEmpty || lastNameTxt.text!.count == 0 || emailTxt.text!.count == 0{
            alert1 = UIAlertController(title: "Required", message: "Please fill in all the information", preferredStyle: .alert)
            alert1.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert1, animated: true)
        }
        else{
            alert2 = UIAlertController(title: "Success", message: "Thank you for signing up for the newsletter!", preferredStyle: .alert)
            alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            let myData: Data = Data()
            myData.initWithData(theRow: 1, theFirstName: firstNameTxt.text!, theEmail: emailTxt.text!, theLastName: lastNameTxt.text!)
            if appDelegate.insertIntoDatabase(entry: myData){
                self.present(alert2, animated: true, completion: nil)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastNameTxt.delegate = self
        firstNameTxt.delegate = self
        emailTxt.delegate = self
    }
}
