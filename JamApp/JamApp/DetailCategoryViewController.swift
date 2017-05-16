//
//  DetailCategoryViewController.swift
//  JamApp
//
//  Created by Vladyslav Kostenko on 04/04/2017.
//  Copyright © 2017 Vlados. All rights reserved.
//

import UIKit

class DetailCategoryViewController: UIViewController {
    
    
    @IBOutlet weak var imgrecipe: UIImageView!
    @IBOutlet weak var lblDescrRecipe: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    var lblTitle: String = ""
    var imgRecipe: String = ""
    var lblDescRecipe: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblDescrRecipe.text = lblDescRecipe
        labelTitle.text = lblTitle
        imgrecipe.image = UIImage(named: imgRecipe)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
