//
//  CustomerSignUpViewController.swift
//  iOSBootleggersFinalProject
//
//  This class is used to control the behaviour of the "Customer sign up" view

import UIKit

class CustomerSignUpViewController : UIViewController, UITextFieldDelegate {
    
    //text fields for user input
    @IBOutlet var firstNameTxt: UITextField!
    @IBOutlet var lastNameTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    //button for the user to submit the info when the fields are filled
    @IBOutlet var submitBtn: UIButton!
    //reference to app's AppDelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Method to submit the customer's info to the newsletter
    //since we obviously don't have a server to receive this info
    //I just stored the data in the sql datavase in the phone
    @IBAction func submitInfoToNewsletter(){
        //ui alert controllers to notify the user of error/success
        let alert1: UIAlertController
        let alert2: UIAlertController
        
        //if any of the text fields are empty...
        if firstNameTxt.text!.isEmpty || lastNameTxt.text!.count == 0 || emailTxt.text!.count == 0{
            //instanciate the uialertcontroller telling the user that the information if required
            alert1 = UIAlertController(title: "Required", message: "Please fill in all the information", preferredStyle: .alert)
            //add an ok button
            alert1.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            //present the alert
            self.present(alert1, animated: true)
        }
        //if the information is input correctly...
        else{
            //instanciate the alert controller
            alert2 = UIAlertController(title: "Success", message: "Thank you for signing up for the newsletter!", preferredStyle: .alert)
            alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            //create an instance of the helper class to fill the information
            let myData: Data = Data()
            //instanciate it with the user's input
            myData.initWithData(theRow: 1, theFirstName: firstNameTxt.text!, theEmail: emailTxt.text!, theLastName: lastNameTxt.text!)
            //insert the data to the database
            if appDelegate.insertIntoDatabase(entry: myData){
                self.present(alert2, animated: true, completion: nil)
            }
        }
    }
    
    //when the user taps return, this method is called and
    //tells the textField that it has been asked to relinquish the status as first responder
    //which in turn makes the keyboard go away
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    //set the delegates of the text fields so they can be released from the screen
    //when the user taps Return
    override func viewDidLoad() {
        super.viewDidLoad()
        lastNameTxt.delegate = self
        firstNameTxt.delegate = self
        emailTxt.delegate = self
    }
}
