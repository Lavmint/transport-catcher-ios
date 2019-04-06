//
//  ArrivalTimesView.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 29/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

class ArrivalTimesView: UIView {
    
    @IBOutlet var tableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        backgroundColor = UIColor.Application.background
    }
    
    func configure() {
        tableView.register(UINib.init(nibName: ArrivalTableViewCell.stringClass, bundle: nil), forCellReuseIdentifier: ArrivalTableViewCell.stringClass)
    }
    
    func reload() {
        tableView.contentOffset = CGPoint.zero
        tableView.layoutIfNeeded()
        tableView.reloadData()
    }
}
