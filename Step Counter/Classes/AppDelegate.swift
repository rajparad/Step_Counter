//
//  AppDelegate.swift
//  Step Counter
//
//  Created by Mark Zarak on 2022-03-25.
//  This file will perform all necessary database operations

import UIKit
import SQLite3
import FBSDKCoreKit
import GoogleSignIn
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
   
        // Declaring varible for database operations
        //Author: Dhruv Rajpara
            var databaseName : String? = "StepCounter.db"
            var databasePath : String?
            var theData : [Data] = []
    
    //to check user is registed is not
    //Author: Dhruv Rajpara
            var validateRegister = false
    //Gmail Sign-in Object
    //Author: Dhruv Rajpara
    let signInConfig = GIDConfiguration.init(clientID: "321787342516-m1rtag8thjr18cr1qu6ep9ie4ris2gfq.apps.googleusercontent.com")
  

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
         //launch facebook
        ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions)
        //Serach for Documentpaths
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                                
                                
                                 let documentsDir = documentPaths[0]
                                 
                                 // append filename such that path is ~/Documents/MyDatabase.db
                                //Append file name to ~/Documents/StepCounter.db
                                 databasePath = documentsDir.appending("/" + databaseName!)
        checkAndCreateDatabase()
        readDataFromDatabase()
        return true
    }

    // allows facebook url to open
    // Devansh Patel
    func application(
            _ app: UIApplication,
            open url: URL,
            options: [UIApplication.OpenURLOptionsKey : Any] = [:]
        ) -> Bool {
            
            ApplicationDelegate.shared.application(
                app,
                open: url,
                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
            )
            
            //return the instance of gmail
            //Author: Dhruv Rajpara
        return GIDSignIn.sharedInstance.handle(url)
              
            
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

    
    
    func checkAndCreateDatabase()
          {

        //This method will check and create database in simulator
        //Author: Dhruv Rajpara
              var success = false
              let fileManager = FileManager.default
              
              success = fileManager.fileExists(atPath: databasePath!)
          
              if success
              {
                  return
              }
          
          //if there is no path below code will save the path
              let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
              
          
          // copy file StepCOunter.db into ~/Documents/StepCounter.db
              try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
          
          // return to didFinishLaunching (don't forget to call this method there)
          return;
          }
    
    func readDataFromDatabase()
               {
               //This method will read all the data from database.
              //Author: Dhruv Rajpara
                   
               theData.removeAll()
               
               // define db object
                   var db: OpaquePointer? = nil
                   
                   // open connection to db file
                   if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
                       print("Successfully opened connection to database at \(self.databasePath)")
                       
                       //  preparing queries
                       var queryStatement: OpaquePointer? = nil
                       var queryStatementString : String = "select * from entries"
                       
                       //  setup object that will handle data transfer
                       if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                           
                           //  loop through row by row to extract data
                           while( sqlite3_step(queryStatement) == SQLITE_ROW ) {
                           
                               let id  : Int = Int(sqlite3_column_int(queryStatement, 0))
                               let cname = sqlite3_column_text(queryStatement, 1)
                               let cemail = sqlite3_column_text(queryStatement, 2)
                               let cpassword = sqlite3_column_text(queryStatement, 3)
                               let name = String(cString: cname!)
                               let email = String(cString: cemail!)
                               let password = String(cString: cpassword!)
                               let data : Data = Data.init()
                               data.initWithData(theRow: id, theName: name, theEmail: email, thePassword: password)
                               //Append the data
                               theData.append(data)
                               
                               //printing the values in console for debugging purpose
                               print("Query Result: \(email) ")
                              
                              
                               
                           }
                           //  clean up
                           
                           sqlite3_finalize(queryStatement)
                       } else {
                           print("SELECT statement could not be prepared")
                       }
                       
                       sqlite3_close(db);

                   } else {
                       print("Unable to open database.")
                   }
               
               }
    
    
    
        
    func insertIntoDatabase(person : Data) -> Bool
                 {
                     //This function will insert data into Database
                     //Author: Dhruv Rajpara
                    //Define sqlite3 object to interact with db
                     var db: OpaquePointer? = nil
                     var returnCode : Bool = true
                     
                     //  open connection
                     if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
                         print("Successfully opened connection to database at \(self.databasePath)")
                         
                         //inserting into entries table
                         var insertStatement: OpaquePointer? = nil
                         var insertStatementString : String = "insert into entries values(NULL, ?, ?, ?)"
                         
                         // setup object that will handle data transfer
                         if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                            
                        
                             // attach items from data object to query
                             
                             
                             let nameStr = person.name! as NSString
                             let emailStr = person.email! as NSString
                             let passwordStr = person.password! as NSString
                             
                           
                             
                             
                             sqlite3_bind_text(insertStatement, 1, nameStr.utf8String, -1, nil)
                             sqlite3_bind_text(insertStatement, 2, emailStr.utf8String, -1, nil)
                             sqlite3_bind_text(insertStatement, 3, passwordStr.utf8String, -1, nil)
                            
                           
                             
                           //complete insert statement
                             if sqlite3_step(insertStatement) == SQLITE_DONE {
                                 let rowID = sqlite3_last_insert_rowid(db)
                                 print("Successfully inserted row. \(rowID)")
                                 
                                 //if user is registered this will change the value to true
                                 //Author: Dhruv Rajpara
                                 validateRegister = true
                             } else {
                                 print("Could not insert row.")
                                 returnCode = false
                             }
                             // clean up
                             sqlite3_finalize(insertStatement)
                         } else {
                             print("INSERT statement could not be prepared.")
                             returnCode = false
                         }
                         
                         
                         //database connection close
                         sqlite3_close(db);
                         
                     } else {
                         print("Unable to open database.")
                         returnCode = false
                     }
                     return returnCode
                 }
                
    }

         
  


