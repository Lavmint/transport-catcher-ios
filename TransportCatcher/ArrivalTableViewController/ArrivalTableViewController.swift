//
//  StopArrivalTableViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 24/09/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import ToSMR

internal class ArrivalTableViewController: UITableViewController {
    
    private(set) var dataSource: ArrivalTableViewDataSource!
    private(set) var stopId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = ArrivalTableViewDataSource()
        tableView.dataSource = dataSource
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    func configure(withStopId stopId: Int) {
        self.stopId = stopId
        Service.shared.approximateArrivals(toStop: stopId) { [weak self] (box) in
            guard let wself = self, stopId == wself.stopId else { return }
            switch box.result {
            case .succeed(let arrivals):
                wself.dataSource.reload(tableView: wself.tableView, arrivals: arrivals ?? [])
            case .error(let error):
                let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
                wself.present(alert, animated: true, completion: nil)
            }
        }
    }
}
