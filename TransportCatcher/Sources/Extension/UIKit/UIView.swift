//
//  UIView.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 21/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

extension UIView {
    
    func presentOverlayView(view: UIView?) {
        let emptyViewIdentifier = "emptyViewIdentifier"
        if let emptyView = view {
            emptyView.accessibilityIdentifier = emptyViewIdentifier
            NSLayoutConstraint.dock(view: emptyView, in: self)
            self.bringSubview(toFront: emptyView)
        } else {
            subviews.filter({ $0.accessibilityIdentifier == emptyViewIdentifier }).forEach({ $0.removeFromSuperview() })
        }
    }
}
