//
//  UIColor.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 24/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

extension UIColor {
    
    enum ArrivalCell {
        
        static var busVehicle: UIColor {
            return #colorLiteral(red: 0.3019607843, green: 0.7137254902, blue: 0.6745098039, alpha: 1)
        }
        
        static var tramwayVehicle: UIColor {
            return #colorLiteral(red: 0.8980392157, green: 0.4509803922, blue: 0.4509803922, alpha: 1)
        }
        
        static var trolleybusVehicle: UIColor {
            return #colorLiteral(red: 0.3921568627, green: 0.7098039216, blue: 0.9647058824, alpha: 1)
        }
    }
}
