//
//  ZoomedPhotoViewController.swift
//  JamApp
//
//  Created by Vladyslav Kostenko on 03/03/2017.
//  Copyright © 2017 Vlados. All rights reserved.
//

import UIKit

class ZoomedPhotoViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBAction func buttonOffer(_ sender: Any) {
        if let url = NSURL(string:"http://balham.ru/shop/"){UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)}
    }
    var photoName: String!
    var descriptionOfJam: String!

    override func viewDidLoad() {
        imageView.image = UIImage(named: photoName)
        labelDescription.text = descriptionOfJam
        
    }
    

}


