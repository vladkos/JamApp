//
//  ViewController.swift
//  JamApp
//
//  Created by Vladyslav Kostenko on 28/02/2017.
//  Copyright © 2017 Vlados. All rights reserved.
//

import UIKit

//var databasePath = NSString()

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.addSlideMenuButton()
//        let filemgr = FileManager.default
//        let dirPaths = filemgr.urls(for: .documentDirectory,
//                                    in: .userDomainMask)
//        
//        copyDatabaseIfNeeded()
//        databasePath = dirPaths[0].appendingPathComponent("Recipes.sqlite").path as NSString
//        
//        if !filemgr.fileExists(atPath: databasePath as String) {
//            
//            let contactDB = FMDatabase(path: databasePath as String)
//            
//            if contactDB == nil {
//                print("Error: \(contactDB?.lastErrorMessage())")
//            }
//            
//            if (contactDB?.open())! {
//                //let sql_stmt = "CREATE TABLE IF NOT EXISTS Jam (ID INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT)"
//                //if !(contactDB?.executeStatements(sql_stmt))! {
//                    print("Error: \(contactDB?.lastErrorMessage())")
////                }
//                contactDB?.close()
//            } else {
//                print("Error: \(contactDB?.lastErrorMessage())")
//            }
//        }else {
//            print("Error: ")
//        }
        // burger side bar menu
        
        
    }
    
    func copyDatabaseIfNeeded() {
        // Move database file from bundle to documents folder
        
        let fileManager = FileManager.default
        
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        
        guard documentsUrl.count != 0 else {
            return // Could not find documents URL
        }
        
        let finalDatabaseURL = documentsUrl.first!.appendingPathComponent("Recipes.sqlite")
        
        if !( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            print("DB does not exist in documents folder")
            
            let documentsURL = Bundle.main.resourceURL?.appendingPathComponent("Recipes.sqlite")
            
            do {
                try fileManager.copyItem(atPath: (documentsURL?.path)!, toPath: finalDatabaseURL.path)
            } catch let error as NSError {
                print("Couldn't copy file to final location! Error:\(error.description)")
            }
            
        } else {
            print("Database file found at path: \(finalDatabaseURL.path)")
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

