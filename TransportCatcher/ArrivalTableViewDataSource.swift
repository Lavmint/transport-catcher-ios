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
    var arrivals: [Arrival]
    
    override init() {
        self.arrivalCellIdentifier = "ArrivalTableViewCell"
        self.arrivals = []
        super.init()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: arrivalCellIdentifier, for: indexPath)
        let arrival = arrivals[indexPath.row]
        cell.textLabel?.text = arrival.number
        cell.detailTextLabel?.text = String(arrival.time)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrivals.count < 1 ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrivals.count
    }
}
