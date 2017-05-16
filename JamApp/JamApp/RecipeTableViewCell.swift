//
//  RecipeTableViewCell.swift
//  JamApp
//
//  Created by Vladyslav Kostenko on 07/04/2017.
//  Copyright © 2017 Vlados. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var imgRecipe: UIImageView!
    @IBOutlet weak var labelRecipe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
