//
//  PlayVC.swift
//  JamApp
//
//  Created by Vladyslav Kostenko on 02/03/2017.
//  Copyright © 2017 Vlados. All rights reserved.
//

import UIKit

class Categories: UITableViewController {

    var queue: FMDatabaseQueue?
    fileprivate var categories:[String] = []
    var fruits = ["Apple", "Apricot", "Banana", "Blueberry", "Cantaloupe", "Cherry",
                  "Clementine", "Coconut", "Cranberry", "Fig", "Grape", "Grapefruit",
                  "Kiwi fruit", "Lemon", "Lime", "Lychee", "Mandarine", "Mango",
                  "Melon", "Nectarine", "Olive", "Orange", "Papaya", "Peach",
                  "Pear", "Pineapple", "Raspberry", "Strawberry"]
    override func viewDidLoad() {

        let db = FMDatabase(path: databasePath as String)
        
        queue = FMDatabaseQueue(path: databasePath as String!)
        
        if (db?.open())! {
            
            queue?.inDatabase() {
                db in
                
                if let rs = db?.executeQuery("select Name from Categori", withArgumentsIn:nil) {
                    while rs.next() {
                        if (rs.string(forColumn: "Name")) != nil{
                            self.categories.append(rs.string(forColumn: "Name"))
                            
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
        
//        // burger side bar menu
//        if revealViewController() != nil{
//            menuButton.target = revealViewController()
//            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
//            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        }

        self.title = "Категории"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fruits.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) //as! CategoryCell
        
        let fruitName = fruits[indexPath.row]
        cell.textLabel?.text = fruitName
        cell.detailTextLabel?.text = "Delicious!"
        cell.imageView?.image = UIImage(named: fruitName)
        
        return cell    }


}
