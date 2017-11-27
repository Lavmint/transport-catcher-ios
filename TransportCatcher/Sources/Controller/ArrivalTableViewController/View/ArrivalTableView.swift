//
//  ArrivalTableView.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 27/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import ToSMR

class ArrivalTableView: UITableView {
    
    enum Cell {
        static let arrival = String(describing: ArrivalTableViewCell.self)
    }
    
    private(set) var arrivals: [Arrival]
    
    required init?(coder aDecoder: NSCoder) {
        arrivals = []
        super.init(coder: aDecoder)
        self.dataSource = self
        self.register(UINib.init(nibName: Cell.arrival, bundle: nil), forCellReuseIdentifier: Cell.arrival)
    }
    
    func reload(with arrivals: [Arrival]) {
        self.arrivals = arrivals
        reloadData()
    }
}

extension ArrivalTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.arrival, for: indexPath) as! ArrivalTableViewCell
        cell.configure(arrival: arrivals[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrivals.count < 1 ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrivals.count
    }
    
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    private func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
