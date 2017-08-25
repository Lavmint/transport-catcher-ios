//
//  ViewController.swift
//  ToSMRExample
//
//  Created by Alexey Averkin on 26/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import MapKit
import ToSMR

class ViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    fileprivate(set) var stops: [TransportStop] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        Service.shared.stops { [weak self] (box) in
            guard let vc = self else { return }
            switch box.result {
            case .succeed(let stops):
                vc.stops = stops ?? []
                vc.onStopsLoaded()
            case .error(let error):
                let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
                vc.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func onStopsLoaded() {
        
    }
}

extension ViewController: MKMapViewDelegate {
    
}

