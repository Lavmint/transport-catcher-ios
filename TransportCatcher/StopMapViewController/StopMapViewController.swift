//
//  ViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 25/06/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import ToSMR

internal class StopMapViewController: UIViewController {
    
    @IBOutlet var stopMapView: StopMapView!
    
    var stopMapViewDelegate: StopMapViewDelegate!
    
    private(set) var stopArrivalTableController: ArrivalTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        reloadData()
    }
    
    func reloadData() {
        
        stopMapViewDelegate = StopMapViewDelegate()
        stopMapViewDelegate.didSelectStop = onSelectedStopChanged
        stopMapView.delegate = stopMapViewDelegate
        stopMapView.configure()
        
        Service.shared.stops { [weak self] (box) in
            guard let wself = self else { return }
            switch box.result {
            case .succeed(let stops):
                guard let unwrappedStops = stops else { return }
                let annotations: [TransportStopAnnotation] = unwrappedStops.map({ TransportStopAnnotation(stop: $0) })
                wself.stopMapView.addAnnotations(annotations)
            case .error(let error):
                let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
                wself.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func onSelectedStopChanged(stopId: Int) {
        stopArrivalTableController.configure(withStopId: stopId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let arrivalController = segue.destination as? ArrivalTableViewController {
            self.stopArrivalTableController = arrivalController
        }
    }
}
