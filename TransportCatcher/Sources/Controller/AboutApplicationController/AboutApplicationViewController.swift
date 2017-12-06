//
//  AboutApplicationViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 06/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

class AboutApplicationViewController: UIViewController {

    @IBOutlet var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onToSamaraTapped(_ sender: UITapGestureRecognizer) {
        guard let url = URL.init(string: "http://tosamara.ru") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func on2GISTapped(_ sender: UITapGestureRecognizer) {
        guard let url = URL.init(string: "https://info.2gis.ru") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func onIcons8Tapped(_ sender: UITapGestureRecognizer) {
        guard let url = URL.init(string: "https://icons8.ru") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
