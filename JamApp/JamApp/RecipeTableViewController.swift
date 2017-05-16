//
//  RecipeTableTableViewController.swift
//  JamApp
//
//  Created by Vladyslav Kostenko on 07/04/2017.
//  Copyright © 2017 Vlados. All rights reserved.
//

import UIKit

var databasePath = NSString()

class RecipeTableViewController: UITableViewController {

    fileprivate let thumbnailSize:CGFloat = 170.0
    fileprivate let sectionInsets = UIEdgeInsets(top: 30, left: 15.0, bottom: 10.0, right: 5.0)
    var recipesArray = [Recipe]()
    var filteredRecipes = [Recipe]()
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var queue: FMDatabaseQueue?
    override func viewDidLoad() {
        recipesArray =  Recipe.downloadAllPhotos()

        
        // burger side bar menu
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func filterContentForSearchText(searchText: String){
        filteredRecipes = recipesArray.filter{
            recipe in return recipe.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredRecipes.count
        }
        return recipesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Recipe Cell", for: indexPath) as! RecipeTableViewCell

        let recipe: Recipe
        if searchController.isActive && searchController.searchBar.text != "" {
            recipe = filteredRecipes[indexPath.row]
        } else {
            recipe = recipesArray[indexPath.row]
        }
        let fullSizedImage = UIImage(named:recipe.image)
        cell.imgRecipe.image = fullSizedImage?.thumbnailOfSize(thumbnailSize)
        cell.labelRecipe.text = recipe.name
        
        // Configure the cell...

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
        if let cell = sender as? UITableViewCell, let indexPath = tableView?.indexPath(for: cell), let zoomedPhotoViewController = segue.destination as? RecipeViewController {
            let recipe: Recipe
            if searchController.isActive && searchController.searchBar.text != "" {
                recipe = filteredRecipes[indexPath.row]
            } else {
                recipe = recipesArray[indexPath.row]
            }
            zoomedPhotoViewController.photoName = recipe.image
            zoomedPhotoViewController.recipeOfJam = recipe.description
            zoomedPhotoViewController.titleOfRecipe = recipe.name
        }
    }

}

extension RecipeTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
