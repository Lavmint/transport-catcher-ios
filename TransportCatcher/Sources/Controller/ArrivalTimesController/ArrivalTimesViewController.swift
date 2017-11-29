//
//  ArrivalTimesViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 29/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import ToSMR

class ArrivalTimesViewController: UIViewController, GenericView {

    typealias View = ArrivalTimesView
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func reload(withStopId stopId: Int) {
        Service.shared.approximateArrivals(toStop: stopId) { [weak self] (box) in
            guard let wself = self, stopId == stopId else { return }
            switch box.result {
            case .succeed(let arrivals):
                wself.genericView.arrivalsTableView.reload(with: arrivals ?? [])
            case .error(let error):
                let alert = UIAlertController.singleActionAlert(aTitle: LocalizedString.Alert.OK, message: error.localizedDescription)
                wself.present(alert, animated: true, completion: nil)
            }
        }
    }
}
