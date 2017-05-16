//
//  CategoriesTableViewController.swift
//  JamApp
//
//  Created by Vladyslav Kostenko on 20/03/2017.
//  Copyright © 2017 Vlados. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    fileprivate let thumbnailSize:CGFloat = 170.0
    
    var queue: FMDatabaseQueue?
    fileprivate var photos:[String] = []
    fileprivate var titles:[String] = []
    fileprivate var descriptions:[String] = []
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBAction func menuButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "nextView", sender: self)
    }
    var category: String = ""
//    var recipes = Recipe.downloadAllPhotos()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 250.0
        
        let db = FMDatabase(path: databasePath as String)
        
        queue = FMDatabaseQueue(path: databasePath as String!)
        
        if (db?.open())! {
            
            queue?.inDatabase() {
                db in
                
                if let rs = db?.executeQuery("select * from Recipes where IdCategori = (select IdCategori from Categori where Name = '\(self.category)')", withArgumentsIn:nil) {
                    while rs.next() {
                        if (rs.string(forColumn: "Foto")) != nil{
                            self.photos.append(rs.string(forColumn: "Foto"))
                            
                        }
                        if (rs.string(forColumn: "MethodOfCooking")) != nil{
                            self.descriptions.append(rs.string(forColumn: "MethodOfCooking"))
                            
                        }
                        if (rs.string(forColumn: "Name")) != nil{
                            self.titles.append(rs.string(forColumn: "Name"))
                            
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
        
        // burger side bar menu
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeScreen" {
            let viewController = segue.destination as! DetailCategoryViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedImg = photos[indexPath.row]
                let selectedTitle = titles[indexPath.row]
                let selectedDescr = descriptions[indexPath.row]
                viewController.lblTitle = selectedTitle
                viewController.lblDescRecipe = selectedDescr
                viewController.imgRecipe = selectedImg
            }
        }

    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return photos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CategoryTableViewCell
        let fullSizedImage = UIImage(named:photos[indexPath.row])
        cell.theViewImage.image = fullSizedImage?.thumbnailOfSize(thumbnailSize)
        cell.titleLabel.text = titles[indexPath.row]
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "changeScreen", sender: nil)
//    }
    
}
