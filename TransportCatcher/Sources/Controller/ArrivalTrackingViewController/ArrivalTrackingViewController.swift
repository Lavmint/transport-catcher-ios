//
//  ArrivalToStopViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 27/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

class ArrivalTrackingViewController: UIViewController {
    
    private(set) var trackingViewController: TrackingViewController!
    private(set) var arrivalTimesViewController: ArrivalTimesViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trackingViewController.genericView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case is ArrivalTimesViewController:
            arrivalTimesViewController = segue.destination as? ArrivalTimesViewController
        case is TrackingViewController:
            trackingViewController = segue.destination as? TrackingViewController
        default:
            break
        }
    }
}

extension ArrivalTrackingViewController: TrackingViewDelegate {

    func trackingView(_ trackingView: TrackingView, didSelect stopId: Int) {
        arrivalTimesViewController.reload(withStopId: stopId)
    }
}

