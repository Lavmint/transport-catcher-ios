//
//  ArrivalToStopViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 27/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

class ArrivalToStopViewController: UIViewController {
    
    private(set) var transportStopMapViewController: TransportStopMapViewController!
    private(set) var arrivalTableViewController: ArrivalTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transportStopMapViewController.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case is ArrivalTableViewController:
            arrivalTableViewController = segue.destination as? ArrivalTableViewController
        case is TransportStopMapViewController:
            transportStopMapViewController = segue.destination as? TransportStopMapViewController
        default:
            break
        }
    }
}

extension ArrivalToStopViewController: TransportStopMapViewDelegate {

    func mapView(_ mapView: DGSMapView, didSelect stopId: Int) {
        guard let arrivalController = arrivalTableViewController else { return }
        arrivalController.configure(withStopId: stopId)
    }
}

