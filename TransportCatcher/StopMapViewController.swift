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
    
    private(set) var stopMapView: StopMapView!
    private(set) var stopMapViewTableViewDataSource: StopMapTableViewDataSource!
    private(set) var stopMapViewMapViewDelegate: StopMapViewMKMapViewDelegate!
    
    override func loadView() {
        stopMapView = StopMapView.loadFromNib()
        view = stopMapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        reloadData()
    }
    
    func reloadData() {
        
        stopMapViewMapViewDelegate = StopMapViewMKMapViewDelegate()
        stopMapView.mapView.delegate = stopMapViewMapViewDelegate
        stopMapView.configure()
        
        stopMapViewTableViewDataSource = StopMapTableViewDataSource()
        stopMapView.tableView.dataSource = stopMapViewTableViewDataSource
        
        Service.shared.stops { [weak self] (box) in
            guard let wself = self else { return }
            switch box.result {
            case .succeed(let stops):
                guard let unwrappedStops = stops else { return }
                let annotations: [TransportStopAnnotation] = unwrappedStops.map({ TransportStopAnnotation(stop: $0) })
                wself.stopMapView.mapView.addAnnotations(annotations)
            case .error(let error):
                let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
                wself.present(alert, animated: true, completion: nil)
            }
        }
    }
}
