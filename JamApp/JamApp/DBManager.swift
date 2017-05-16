//
//  DBManager.swift
//  JamApp
//
//  Created by Vladyslav Kostenko on 07/03/2017.
//  Copyright © 2017 Vlados. All rights reserved.
//

import UIKit

class DBManager: NSObject {

    static let shared: DBManager = DBManager()
    
    
    let databaseFileName = "database.sqlite"
    
    var pathToDatabase: String!
    
    var database: FMDatabase!
    
}
