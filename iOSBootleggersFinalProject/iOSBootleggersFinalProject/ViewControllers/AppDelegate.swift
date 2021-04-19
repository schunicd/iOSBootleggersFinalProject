//
//  AppDelegate.swift
//  iOSBootleggersFinalProject
//
//  Created by  on 3/18/21.
//

import UIKit
import SQLite3
import MediaPlayer


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var menuItem = " "
    var menuPrice1 = " "
    var menuPrice2 = " "
    var menuImage = " "
    
    //<Lucas>
    //strings to hold the database name and path in the app
    var databaseName : String? = "FinalDatabase.sql"
    var databasePath : String?
    //array of customer signed up for the newsletter
    var entries : [Data] = []
    //variable used to hold the apple music controller
    var musicPlayer: MPMusicPlayerApplicationController?
    //</lucas>
    
    
    //variable accessed in EventsViewController and SpotlightViewController, used to determine if
    //SpotlightViewController should display webpage for spotlightOne or spotlightTwo
    var spotlightOneMoreInfo = true

    //<lucas>
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //get the path of the apps document directory
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        //append the database name to get the path to the .sql file
        let documentsDir = documentPaths[0]
        databasePath = documentsDir.appending("/" + databaseName!)
        

        //calls these 2 methods to make sure data is available from the db
        //and loads them
        checkAndCreateDatabase()
        readDataFromDatabase()
        
        //get the apple music player and set it's queue with the user's songs
        musicPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer
        musicPlayer!.setQueue(with: .songs())
        
        return true
    }
    //</lucas>
    
    //<lucas>
    func checkAndCreateDatabase(){
        var success = false
        let fileManager = FileManager.default
        
        //check if the database file actually exists in the database path
        success = fileManager.fileExists(atPath: databasePath!)
        
        
        //if it does, nothing to do, return
        if success{
            return
        }
        
        //else, copy it from the app to the database path
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
        
        return
    }
    //</lucas>
    
    
    //<lucas>
    func readDataFromDatabase(){
        //clear array of data when first loading
        entries.removeAll()
        //create a pointer capable of holding C objects
        var db : OpaquePointer? = nil
        
        //attempt to open the db and continue if connection is successful
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Able to open database at path \(self.databasePath)")
            
            //variables used to prepare and create the SQL query
            var queryStatement: OpaquePointer? = nil
            let queryStatementString : String = "select * from entries"
            
            //use the query pointer, query string and db pointer to prepare the query
            //to be run, if successful continue
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                //iterate through the results
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    //retrieve the row's result into variables
                    let id : Int = Int(sqlite3_column_int(queryStatement, 0))
                    let fname = sqlite3_column_text(queryStatement, 1)
                    let lname = sqlite3_column_text(queryStatement, 2)
                    let email = sqlite3_column_text(queryStatement, 3)

                    //convert the results into the necessary types
                    let firstname = String(cString: fname!)
                    let lastname = String(cString: lname!)
                    let eemail = String(cString: email!)

                    //use the retrieved and converted row's data to instanciate
                    //a helper class with the data
                    let data : Data = Data.init()
                    data.initWithData(theRow: id, theFirstName: firstname, theEmail: eemail, theLastName: lastname)
                    
                    //add the newly created object to the array
                    entries.append(data)
                    
                    print("Query result")
                    print("\(id) \(firstname) \(lastname) \(eemail)")
                    
                }
                //finalize the query
                sqlite3_finalize(queryStatement)
            }
            else {
                print("Select statement could not be prepared")
            }
            //close the connection to the db when done
            sqlite3_close(db)
        }
        else {
            print("Unable to open database")
        }
    }
    //</lucas>
    
    func insertIntoDatabase(entry : Data) -> Bool
    {
        //create a pointer capable of holding C objects
        var db: OpaquePointer? = nil
        //boolean variable to hold return code of method
        var returnCode : Bool = true
        
        //attempt to open a connection to the db using the c pointer and the database path
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(self.databasePath)")
            
            //variables used to prepare and create the SQL query
            var insertStatement: OpaquePointer? = nil
            let insertStatementString : String = "insert into entries values(NULL, ?, ?, ?)"
            
            //use the query pointer, query string and db pointer to prepare the query
            //to be run, if successful continue
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {

                // cast the data to be inserted to required NSString
                let firstName = entry.firstName! as NSString
                let lastName = entry.lastName! as NSString
                let email = entry.email! as NSString
                
                //bind the newly created NSStrings to their respective fields in the
                //insert query
                sqlite3_bind_text(insertStatement, 1, firstName.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, lastName.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, email.utf8String, -1, nil)
                
                
                //attempt to insert data
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    let rowID = sqlite3_last_insert_rowid(db)
                    print("Successfully inserted row. \(rowID)")
                } else {
                    print("Could not insert row.")
                    returnCode = false
                }
                //end the insert query
                sqlite3_finalize(insertStatement)
            } else {
                print("INSERT statement could not be prepared.")
                returnCode = false
            }
            //close the connection to the database
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

