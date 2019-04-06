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
    
    enum Application {
        
        static var primary: UIColor {
            return #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        }
        
        static var primaryLight: UIColor {
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        static var primaryDark: UIColor {
            return #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
        }
        
        static var secondary: UIColor {
            return #colorLiteral(red: 0.5058823529, green: 0.831372549, blue: 0.9803921569, alpha: 1)
        }

        static var secondaryLight: UIColor {
            return #colorLiteral(red: 0.9529411765, green: 0.9490196078, blue: 0.9568627451, alpha: 1)
        }

        static var secondaryDark: UIColor {
            return #colorLiteral(red: 0.9529411765, green: 0.9490196078, blue: 0.9568627451, alpha: 1)
        }
        
        static var background: UIColor {
            return #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9647058824, alpha: 1)
        }
    }
}
