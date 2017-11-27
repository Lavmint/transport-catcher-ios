//
//  StopMapViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 27/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import ToSMR

internal class TransportStopMapViewController: UIViewController {
    
    @IBOutlet var stopMapView: TransportStopMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        reloadData()
    }
    
    func reloadData() {
        
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
}
