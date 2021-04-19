//
//  AppDelegate.swift
//  iOSBootleggersFinalProject
//
//  Created by  on 3/18/21.
//

import UIKit
import SQLite3



@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var databaseName : String? = "FinalDatabase.sql"
    var databasePath : String?
    var entries : [Data] = []

    //variable accessed in EventsViewController and SpotlightViewController, used to determine if
    //SpotlightViewController should display webpage for spotlightOne or spotlightTwo
    var spotlightOneMoreInfo = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let documentsDir = documentPaths[0]
        databasePath = documentsDir.appending("/" + databaseName!)
        
        checkAndCreateDatabase()
        readDataFromDatabase()
        
        return true
    }
    
    func checkAndCreateDatabase(){
        var success = false
        let fileManager = FileManager.default
        
        success = fileManager.fileExists(atPath: databasePath!)
        
        if success{
            return
        }
        
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
        
        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
        
        return
    }
    
    func readDataFromDatabase(){
        entries.removeAll()
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Able to open database at path \(self.databasePath)")
            
            var queryStatement: OpaquePointer? = nil
            let queryStatementString : String = "select * from entries"
            
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let id : Int = Int(sqlite3_column_int(queryStatement, 0))
                    let fname = sqlite3_column_text(queryStatement, 1)
                    let lname = sqlite3_column_text(queryStatement, 2)
                    let email = sqlite3_column_text(queryStatement, 3)

                    
                    let firstname = String(cString: fname!)
                    let lastname = String(cString: lname!)
                    let eemail = String(cString: email!)

                    
                    let data : Data = Data.init()
                    data.initWithData(theRow: id, theFirstName: firstname, theEmail: eemail, theLastName: lastname)
                    
                    entries.append(data)
                    
                    print("Query result")
                    print("\(id) \(firstname) \(lastname) \(eemail)")
                    
                }
                sqlite3_finalize(queryStatement)
            }
            else {
                print("Select statement could not be prepared")
            }
            sqlite3_close(db)
        }
        else {
            print("Unable to open database")
        }
    }
    
    func insertIntoDatabase(entry : Data) -> Bool
    {
        var db: OpaquePointer? = nil
        var returnCode : Bool = true
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(self.databasePath)")
            
            var insertStatement: OpaquePointer? = nil
            let insertStatementString : String = "insert into entries values(NULL, ?, ?, ?)"
            
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {

                let firstName = entry.firstName! as NSString
                let lastName = entry.lastName! as NSString
                let email = entry.email! as NSString
                
                sqlite3_bind_text(insertStatement, 1, firstName.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, lastName.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, email.utf8String, -1, nil)
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    let rowID = sqlite3_last_insert_rowid(db)
                    print("Successfully inserted row. \(rowID)")
                } else {
                    print("Could not insert row.")
                    returnCode = false
                }
                // step 16h - clean up
                sqlite3_finalize(insertStatement)
            } else {
                print("INSERT statement could not be prepared.")
                returnCode = false
            }

            sqlite3_close(db);
            
        } else {
            print("Unable to open database.")
            returnCode = false
        }
        return returnCode
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

