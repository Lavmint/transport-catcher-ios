//
//  NibLoadableView.swift
//  OpenCity
//
//  Created by Alexey Averkin on 06/06/2017.
//  Copyright © 2017 Dmitry Golubev. All rights reserved.
//

import UIKit

protocol NibLoadableView {

}

extension NibLoadableView where Self: UIView {
    
    static func loadFromNib() -> Self! {
        let nibName = "\(self)".components(separatedBy: ".").last!
        return Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? Self
    }
}
