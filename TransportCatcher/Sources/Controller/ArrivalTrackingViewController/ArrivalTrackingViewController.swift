//
//  ArrivalToStopViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 27/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

class ArrivalTrackingViewController: UIViewController {
    
    @IBOutlet var progressView: GradientProgressView!
    private(set) var trackingViewController: TrackingViewController!
    private(set) var arrivalTimesViewController: ArrivalTimesViewController!
    
    private(set) var isBusy: Bool = false {
        didSet {
            trackingViewController.view.isUserInteractionEnabled = !isBusy
            arrivalTimesViewController.view.isUserInteractionEnabled = !isBusy
            isBusy ? progressView.wait() : progressView.signal()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trackingViewController.genericView.delegate = self
        trackingViewController.delegate = self
        arrivalTimesViewController.delegate = self
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

extension ArrivalTrackingViewController: ArrivalTimesViewControllerDelegate {
    
    func willFetchArrivals(arrivalTimesViewController: ArrivalTimesViewController, for stopId: Int) {
        isBusy = true
    }
    
    func didFetchArrivals(arrivalTimesViewController: ArrivalTimesViewController, for stopId: Int) {
        isBusy = false
    }
    
}

extension ArrivalTrackingViewController: TrackingViewControllerDelegate{
    
    func willFetchStops(trackingViewController: TrackingViewController) {
        isBusy = true
    }
    
    func didFetchStops(trackingViewController: TrackingViewController) {
        isBusy = false
    }
    
    func willRequestLocation(trackingViewController: TrackingViewController) {
        isBusy = true
    }
    
    func didReceiveLocation(trackingViewController: TrackingViewController) {
        isBusy = false
    }
    
}
