//
//  AboutProject.swift
//  JamApp
//
//  Created by Vladyslav Kostenko on 02/03/2017.
//  Copyright © 2017 Vlados. All rights reserved.
//

import UIKit

class AboutProject: UIViewController {

    @IBAction func buttonYouTube(_ sender: Any) {
        if let url = NSURL(string:"https://www.youtube.com/channel/UCu3k3m359ibQY80TqdaFMgw"){UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)}
    }
    @IBOutlet weak var labelP: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelP.text = "Миллионер из трущоб!\n\nЯ, обычный парень из обычной семьи, буду зарабатывать миллион и докажу, что все в наших руках.\n\nПервый интернет сериал основанный на реальной жизни!\nЛюбой может стать любым!"
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }}
