//
//  DataTableViewController.swift
//  TableExample
//
//  Created by Ralf Ebert on 19/09/16.
//  Copyright © 2016 Example. All rights reserved.
//

import UIKit

class CatTableViewController: UITableViewController {
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var queue: FMDatabaseQueue?
    fileprivate var categories:[String] = []
    fileprivate var count: [Int] = []
    
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
                if let rs2 = db?.executeQuery("select count(*) count from Recipes group by idCategori", withArgumentsIn:nil) {
                    while rs2.next() {
                        if (rs2.string(forColumn: "count")) != nil{
                            self.count.append(Int(rs2.int(forColumn: "count")))
                            
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
        
        self.title = "Категории"
    
        // burger side bar menu
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegue"{
            let destinationNavigationController = segue.destination as! UINavigationController
        let targetController = destinationNavigationController.topViewController as! CategoriesTableViewController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let selected = categories[indexPath.row]
            targetController.category = selected
        }
    }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let categoryName = categories[indexPath.row]
        cell.textLabel?.text = categoryName
        cell.detailTextLabel?.text = "Кол-во (" + "\(count[indexPath.row]))"
        
        return cell
    }
    
}
