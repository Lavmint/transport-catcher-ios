//
//  TransportStopAnnotationView.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 01/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import MapKit

class TransportStopAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        self.canShowCallout = true
        self.calloutOffset = CGPoint(x: -5, y: 5)
        self.image = #imageLiteral(resourceName: "ic_stop_bus")
    }
}
