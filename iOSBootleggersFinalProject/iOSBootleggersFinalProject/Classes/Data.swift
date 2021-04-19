//
//  Data.swift
//  iOSBootleggersFinalProject
//
//  Created by Lucas Zanlorensi on 2021-04-18.
//

import UIKit

class Data: NSObject {
    
    var id : Int?
    var firstName: String?
    var lastName: String?
    var email: String?

    
    func initWithData(theRow i: Int, theFirstName fName: String, theEmail email: String, theLastName lName: String){
        self.id = i
        self.firstName = fName
        self.lastName = lName
        self.email = email
    }
    

}
