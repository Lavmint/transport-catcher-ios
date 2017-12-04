//
//  UIViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 04/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showIndicator(withText text: String) {
        BottomIndicatorViewPresenter.shared.showIndicator(withText: text)
    }
    
    func hideIndicator() {
        BottomIndicatorViewPresenter.shared.hideIndicator()
    }
}
