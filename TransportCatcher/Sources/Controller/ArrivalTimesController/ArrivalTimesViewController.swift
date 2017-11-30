//
//  ArrivalTimesViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 29/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

class ArrivalTimesViewController: UIViewController, GenericView {

    typealias View = ArrivalTimesView
    private(set) var intercator: ArrivalTimesInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intercator = ArrivalTimesInteractor()
        self.genericView.configure()
        self.genericView.tableView.dataSource = self
    }
    
    func reload(withStopId stopId: Int) {
        intercator.fetchArrivals(toStopId: stopId) { [weak self] in
            self?.genericView.tableView.reloadData()
        }
    }
}

extension ArrivalTimesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArrivalTimesView.Cell.arrival, for: indexPath) as! ArrivalTableViewCell
        cell.configure(arrival: intercator.arrivals[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return intercator.arrivals.count < 1 ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return intercator.arrivals.count
    }
    
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    private func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
