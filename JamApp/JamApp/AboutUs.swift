//
//  AboutUs.swift
//  JamApp
//
//  Created by Vladyslav Kostenko on 02/03/2017.
//  Copyright © 2017 Vlados. All rights reserved.
//

import UIKit

class AboutUs: UIViewController{
    var strings:[String] = []
    
    @IBOutlet weak var lblContinue: UILabel!
    @IBOutlet weak var lblList: UILabel!
    @IBOutlet weak var lblLogo: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        strings = ["Варенье из сосновых шишек;", "Варенье из абрикосов;", "Варенье из лесной черники;", "Варенье из дикой малины;", "Варенье из дикой алычи;", "Варенье из одуванчика;","Варенье из облепихи;", "Варенье из мандаринов;", "Варенье из липы;","Варенье из грецкого ореха;", "Варенье из барбариса;", "Варенье из фейхоа."]
        
        var fullString = ""
        
        for string: String in strings
        {
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint) \(string)\n"
            
            fullString = fullString + formattedString
        }
        lblList.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblList.numberOfLines = 0
        lblList.text = fullString
        
        lblLogo.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblLogo.numberOfLines = 0
        lblLogo.text = "Balham – это не просто интернет магазин, где вы сможете приобрести различные виды варенья изготавливаемые из фруктов и ягод, собираемых в высокогорьях Кавказа у самого подножия Эльбруса. Balham-это настоящая семья,которая собирает всё сырье и готовит для вас натуральное варенье. В нашем ассортименте:"
        lblContinue.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblContinue.numberOfLines = 0
        lblContinue.text = "Все фрукты и ягоды для нашего варенья произрастают на экологически-чистых территориях Карачаево-Черкесской республики. И собираются собственноручно, на высокогорных склонах гор где берет своё начало река Кубань, а также его притоки, такие как р. Теберда, р. Учкулан, р.Дуут, р.Худес, р.Джалан Кол, р.Аман Кол."
        
        
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    func createParagraphAttribute() ->NSParagraphStyle
    {
        var paragraphStyle: NSMutableParagraphStyle
        paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: NSDictionary() as! [String : AnyObject])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 15
        
        return paragraphStyle
    }

}
