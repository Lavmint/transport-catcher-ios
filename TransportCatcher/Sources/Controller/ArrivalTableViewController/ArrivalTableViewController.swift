//
//  ArrivalListViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 27/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import ToSMR

class ArrivalTableViewController: UIViewController {

    @IBOutlet var arrivalTableView: ArrivalTableView!
    
    func configure(withStopId stopId: Int) {
        Service.shared.approximateArrivals(toStop: stopId) { [weak self] (box) in
            guard let wself = self, stopId == stopId else { return }
            switch box.result {
            case .succeed(let arrivals):
                wself.arrivalTableView.reload(with: arrivals ?? [])
            case .error(let error):
                let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
                wself.present(alert, animated: true, completion: nil)
            }
        }
    }

}
