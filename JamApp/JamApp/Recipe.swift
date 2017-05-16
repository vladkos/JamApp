//
//  Recipe.swift
//  JamApp
//
//  Created by Vladyslav Kostenko on 20/03/2017.
//  Copyright © 2017 Vlados. All rights reserved.
//

import Foundation

class Recipe{
    
    

    var name: String = ""
    var description: String = ""
    var image: String = ""
    var category: String = ""
    
    init(name: String, description: String, image: String, category: String) {
        self.name = name
        self.description = description
        self.image = image
        self.category = category
    }
    
    
    
    
    class func downloadAllPhotos() -> [Recipe]
    {
        var queue: FMDatabaseQueue?
        var categories:[String] = []
        var titles:[String] = []
        var images:[String] = []
        var descriptions:[String] = []
        func viewDidLoad() {
            
            let filemgr = FileManager.default
            let dirPaths = filemgr.urls(for: .documentDirectory,
                                        in: .userDomainMask)
            
            copyDatabaseIfNeeded()
            databasePath = dirPaths[0].appendingPathComponent("Recipes.sqlite").path as NSString
        
            let db = FMDatabase(path: databasePath as String)
            
            queue = FMDatabaseQueue(path: databasePath as String!)
            
            if (db?.open())! {
                
                queue?.inDatabase() {
                    db in
                    
                    if let rs = db?.executeQuery("select * from Recipes", withArgumentsIn:nil) {
                        while rs.next() {
                            if (rs.string(forColumn: "Name")) != nil{
                                titles.append(rs.string(forColumn: "Name"))
                                
                            }
                            if (rs.string(forColumn: "Foto")) != nil{
                                images.append(rs.string(forColumn: "Foto"))
                                
                            }
                            if (rs.string(forColumn: "MethodOfCooking")) != nil{
                                descriptions.append(rs.string(forColumn: "MethodOfCooking"))
                                
                            }
                            if (rs.string(forColumn: "IdCategori")) != nil{
                                categories.append(rs.string(forColumn: "IdCategori"))
                                
                            }
                        }
                    } else {
                        print("select failure: \(String(describing: db?.lastErrorMessage()))")
                    }
                }
                db?.close()
            } else {
                print("Error: \(String(describing: db?.lastErrorMessage()))")
            }
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


        viewDidLoad()
        var recipes = [Recipe]()
        for i in 0..<(titles.count) {
            let recipe = Recipe(name: "\(titles[i])", description: "\(descriptions[i])", image: "\(images[i])", category: "\(categories[i])")
            recipes.append(recipe)
        }
        
        return recipes
    }
}
