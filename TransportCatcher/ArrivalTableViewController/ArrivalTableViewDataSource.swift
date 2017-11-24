//
//  StopMapTableViewDataSource.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 17/09/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import ToSMR

internal class ArrivalTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    let arrivalCellIdentifier: String
    private(set) var arrivals: [Arrival]
    
    override init() {
        self.arrivalCellIdentifier = String(describing: ArrivalTableViewCell.self)
        self.arrivals = []
        super.init()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: arrivalCellIdentifier, for: indexPath) as! ArrivalTableViewCell
        cell.configure(arrival: arrivals[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrivals.count < 1 ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrivals.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func reload(tableView: UITableView, arrivals: [Arrival]) {        
        self.arrivals = arrivals
        tableView.reloadData()
    }
}
