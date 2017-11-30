//
//  ArrivalTimesView.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 29/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

class ArrivalTimesView: UIView {
    
    enum Cell {
        static let arrival = String(describing: ArrivalTableViewCell.self)
    }
    
    @IBOutlet var tableView: UITableView!
    
    func configure() {
        tableView.register(UINib.init(nibName: Cell.arrival, bundle: nil), forCellReuseIdentifier: Cell.arrival)
    }
}
