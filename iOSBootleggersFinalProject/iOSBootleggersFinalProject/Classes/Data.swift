//
//  Data.swift
//  iOSBootleggersFinalProject
//
//  Helper Class to reflect the entries table in the sql database

import UIKit

class Data: NSObject {
    
    //table id primary key
    var id : Int?
    //first name string
    var firstName: String?
    //last name string
    var lastName: String?
    //email string
    var email: String?

    //class initializer that takes the necessary data
    func initWithData(theRow i: Int, theFirstName fName: String, theEmail email: String, theLastName lName: String){
        self.id = i
        self.firstName = fName
        self.lastName = lName
        self.email = email
    }
    

}
