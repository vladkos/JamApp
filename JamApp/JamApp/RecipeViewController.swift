//
//  RecipeViewController.swift
//  JamApp
//
//  Created by Vladyslav Kostenko on 07/04/2017.
//  Copyright © 2017 Vlados. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    
    @IBOutlet weak var imageViewRecipe: UIImageView!
    var photoName: String!
    var recipeOfJam: String!
    var titleOfRecipe: String!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var labelRecipe: UILabel!
    override func viewDidLoad() {
        imageViewRecipe.image = UIImage(named: photoName)
        labelRecipe.text = recipeOfJam
        titleLbl.text = titleOfRecipe
        
    }


}
